include {
    path = find_in_parent_folders()
}

terraform {
    source = "${get_parent_terragrunt_dir("root")}/../terraform-modules/documentdb"
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
    db_subnet_ids = dependency.vpc.outputs.db_subnet_ids
    security_group_ids = [dependency.vpc.outputs.docdb_security_group_id]   
}