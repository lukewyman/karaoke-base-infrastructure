output "vpc_id" {
  value = module.karaoke_vpc.vpc_id
}

output "docdb_subnets" {
  value = aws_docdb_subnet_group.docdb_subnets.name
}

output "docdb_security_group_id" {
  value = aws_security_group.documentdb_sg.id
}

output "bastion_subnet_id" {
  value = module.karaoke_vpc.public_subnets[0]
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_sg.id
}
