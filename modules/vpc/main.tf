resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_subnet" "private" {
  coun = length(var.private_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_subnet" "db" {
  count = length(var.db_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = var.db_subnets[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

data "aws_availability_zones" "available" {}

output "vpc_id" { value = aws_vpc.this.id }
output "public_subnets" { value = aws_subnet.public[*].id }
output "private_subnets" { value = aws_subnet.private[*].id }
output "db_subnets" { value = aws_subnet.db[*].id }
