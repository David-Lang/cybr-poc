output "vpc_id" {
  value = module.lab_vpc.vpc_id
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "vpc_private_subnet_ids" {
  value = module.lab_vpc.private_subnets
}

output "vpc_public_subnet_ids" {
  value = module.lab_vpc.public_subnets
}
