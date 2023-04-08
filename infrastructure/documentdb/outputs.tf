output "docdb_endpoint" {
  value = aws_docdb_cluster.docdb.endpoint
}

output "docdb_username_arn" {
  value = aws_ssm_parameter.docdb_username.arn
}

output "docdb_password_arn" {
  value = aws_ssm_parameter.docdb_password.arn
}

output "docdb_port" {
  value = var.port
}