include {
    path = find_in_parent_folders()
}

terraform {
    source = "${get_parent_terragrunt_dir("root")}/../infrastructure/documentdb"
}

dependency "vpc" {
    config_path = "../vpc"
}

inputs = {
    aws_region = "us-west-2"
    engine_version = "4.0.0"
    instance_class = "db.t3.medium"
    instance_count = 1
    port = 27017
    vpc_id = dependency.vpc.outputs.vpc_id
    public_subnets_cidr_blocks = dependency.vpc.outputs.public_subnets_cidr_blocks
    app_subnets_cidr_blocks = dependency.vpc.outputs.app_subnets_cidr_blocks
    db_subnets_ids = dependency.vpc.outputs.db_subnets_ids
}