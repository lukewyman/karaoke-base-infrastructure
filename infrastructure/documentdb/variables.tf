variable "aws_region" {
}

variable "engine_version" {
  description = "Engine version for DocumentDB cluster"
}

variable "instance_class" {
  description = "Instance class for DocumentDB cluster"
}

variable "instance_count" {
  description = "Number of instances for DocumentDB cluster"
}

variable "port" {
  description = "Port for DocumentDB cluster"
}

variable "vpc_id" {
  type = string 
}

variable "public_subnets_cidr_blocks" {
  type = list(string)
}

variable "app_subnets_cidr_blocks" {
  type = list(string)
}

variable "db_subnets_ids" {
  type = list(string)
}
