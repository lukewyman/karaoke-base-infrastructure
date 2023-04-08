include {
    path = find_in_parent_folders()
}

terraform {
    source = "${get_parent_terragrunt_dir("root")}/../infrastructure/ec2"
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
    vpc_id = dependency.vpc.outputs.vpc_id
    subnet_ids = dependency.vpc.outputs.public_subnet_ids
}