resource "aws_docdb_cluster" "docdb" {
  cluster_identifier     = "${local.app_prefix}${terraform.workspace}-cluster"
  engine                 = "docdb"
  engine_version         = var.engine_version
  master_username        = resource.aws_ssm_parameter.docdb_username.value
  master_password        = resource.aws_ssm_parameter.docdb_password.value
  deletion_protection    = false
  port                   = var.port
  db_subnet_group_name   = aws_docdb_subnet_group.docdb_subnets.name 
  vpc_security_group_ids = var.security_group_ids
  skip_final_snapshot    = true
  storage_encrypted      = false
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.instance_count
  identifier         = "${local.app_prefix}${terraform.workspace}-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.instance_class
}

resource "aws_docdb_subnet_group" "docdb_subnets" {
  name       = "${local.app_prefix}${terraform.workspace}-subnet-group"
  subnet_ids = var.db_subnet_ids
}

resource "aws_ssm_parameter" "docdb_username" {
  name = "/app/karaoke/DOCDB_USERNAME"
  type = "String"
  value = "appuser"
}

resource "aws_ssm_parameter" "docdb_password" {
  name = "/app/karaoke/DOCDB_PASSWORD"
  type = "SecureString"
  value = random_password.password.result
}

resource "random_password" "password" {
  length = 8 
  special = false 
}

