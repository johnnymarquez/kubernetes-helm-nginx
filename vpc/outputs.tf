output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_public_1a_id" {
    value = aws_subnet.subnet_public_1a.id
}

output "subnet_public_1b_id" {
    value = aws_subnet.subnet_public_1b.id
}

output "subnet_private_1a_id" {
    value = aws_subnet.subnet_private_1a.id
}

output "subnet_private_1b_id" {
    value = aws_subnet.subnet_private_1b.id
}

output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block
}