output "vpc_id" {
  value = module.karaoke_vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.karaoke_vpc.public_subnets
}

output "ecs_subnet_ids" {
  value = slice(module.karaoke_vpc.private_subnets, 0, 2)
}

output "db_subnet_ids" {
  value = slice(module.karaoke_vpc.private_subnets, 2, 4)
}

output "docdb_security_group_id" {
  value = aws_security_group.documentdb_sg.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_sg.id
}
