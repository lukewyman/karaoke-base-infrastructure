resource "aws_docdb_cluster" "docdb" {
    cluster_identifier = "${local.app_prefix}${terraform.workspace}-cluster"
    engine = "docdb"
    engine_version = var.engine_version
    master_username = data.aws_ssm_parameter.mongo_username.value
    master_password = data.aws_ssm_parameter.mongo_password.value 
    deletion_protection = false
    port = var.port
    db_subnet_group_name = var.subnet_group_name
    vpc_security_group_ids = var.security_group_ids
    skip_final_snapshot = true
    storage_encrypted = false 
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
    count = var.instance_count
    identifier = "${local.app_prefix}${terraform.workspace}-instance-${count.index}"
    cluster_identifier = aws_docdb_cluster.docdb.id 
    instance_class = var.instance_class 
}
