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



