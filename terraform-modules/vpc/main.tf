module "karaoke_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.app_prefix}${terraform.workspace}-vpc"
  cidr = "10.0.0.0/20"

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]

  enable_nat_gateway = true 
  single_nat_gateway = true 
  enable_vpn_gateway = false
}

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


