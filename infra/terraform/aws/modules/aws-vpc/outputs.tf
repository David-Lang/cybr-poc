output "vpc_cidr" {
  value = var.vpc_cidr
}

output "private_subnet_ids" {
  value = module.lab_vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.lab_vpc.public_subnets
}

output "vpc_id" {
  value = module.lab_vpc.vpc_id
}
