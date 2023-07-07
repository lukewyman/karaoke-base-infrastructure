include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../infrastructure/vpc"
}

inputs = {
  aws_region = "us-west-2"
  docdb_port = 27017
}
