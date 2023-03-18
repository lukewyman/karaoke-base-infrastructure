variable "aws_region" {
    default = "us-west-2"
}

variable "engine_version" {
    default = "4.0.0"
    description = "Engine version for DocumentDB cluster"
}

variable "instance_class" {
  default = "db.t3.medium"
  description = "Instance class for DocumentDB cluster"
}

variable "instance_count" {
    default = 1 
    description = "Number of instances for DocumentDB cluster"
}

variable "port" {
    default = "27017"
    description = "Port for DocumentDB cluster"
}

variable "subnet_group_name" {
    default = ""
}

variable "security_group_ids" {
    type = list(string)
    default = ["sg-0f88ec60228e7f6c9"]
}