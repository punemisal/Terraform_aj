resource "aws_vpc" "Vpc-Terraform" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name    = "Vpc-Terraform"
    Service = "Terraform"
  }
}

resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name    = "IGW-Terraform"
    Service = "Terraform"
  }
}