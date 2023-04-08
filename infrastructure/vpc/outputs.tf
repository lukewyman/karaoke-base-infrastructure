output "vpc_id" {
  value = module.karaoke_vpc.vpc_id
}

output "public_subnets_ids" {
  value = module.karaoke_vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  value = module.karaoke_vpc.public_subnets_cidr_blocks
}

output "app_subnets_ids" {
  value = slice(module.karaoke_vpc.private_subnets, 0, 2)
}

output "app_subnets_cidr_blocks" {
  value = slice(sort(module.karaoke_vpc.private_subnets_cidr_blocks), 0, 2)
}

output "db_subnets_ids" {
  value = slice(module.karaoke_vpc.private_subnets, 2, 4)
}

output "db_subnets_cidr_blocks" {
  value = slice(sort(module.karaoke_vpc.private_subnets_cidr_blocks), 2, 4)
}
