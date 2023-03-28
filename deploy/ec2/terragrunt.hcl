include {
    path = find_in_parent_folders()
}

terraform {
    source = "${get_parent_terragrunt_dir("root")}/../terraform-modules/ec2"
}

dependency "vpc" {
    config_path = "../vpc"
}

dependency "documentdb" {
    config_path = "../documentdb"
}

inputs = {
    aws_region = "us-west-2"
    instance_type = "t2.micro"
    subnet_id = dependency.vpc.outputs.bastion_subnet_id
    security_group_id = dependency.vpc.outputs.bastion_security_group_id
}