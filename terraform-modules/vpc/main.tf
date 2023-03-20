module "karaoke_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.app_prefix}${terraform.workspace}-vpc"
  cidr = "10.0.0.0/20"

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
}

resource "aws_docdb_subnet_group" "docdb_subnets" {
  name       = "${local.app_prefix}${terraform.workspace}-docb-subs"
  subnet_ids = slice(module.karaoke_vpc.private_subnets, 2, 4)
}

# resource "aws_vpc_endpoint" "s3_endpoint" {
#   vpc_id = module.karaoke_vpc.vpc_id 
#   service_name = "com.amazonaws.us-west-2.s3"
#   vpc_endpoint_type = "Interface"
# }

# resource "aws_vpc_endpoint" "dynamodb_endpoint" {
#   vpc_id = module.karaoke_vpc.vpc_id 
#   service_name = "com.amazonaws.us-west-2.dynamodb"
#   vpc_endpoint_type = "Interface"
# }

resource "aws_security_group" "bastion_sg" {
  name   = "${local.app_prefix}${terraform.workspace}-bastion-sg"
  vpc_id = module.karaoke_vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "ecs_sg" {
#   name = "${local.app_prefix}${terraform.workspace}-ecs-sg"

# }

resource "aws_security_group" "documentdb_sg" {
  name   = "${local.app_prefix}${terraform.workspace}-docdb-sg"
  vpc_id = module.karaoke_vpc.vpc_id

  ingress {
    from_port = var.docdb_port
    to_port   = var.docdb_port
    protocol  = "tcp"
    cidr_blocks = concat(
      module.karaoke_vpc.public_subnets_cidr_blocks,
      slice(module.karaoke_vpc.private_subnets_cidr_blocks, 0, 2)
    )
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "opensearch_sg" {
#   name = "${local.app_prefix}${terraform.workspace}-opensearch-sg"
# }

# resource "aws_security_group" "vpc_endpoint_sg" {
#   name = "${local.app_prefix}${terraform.workspace}-vpcep-sg"
# }

