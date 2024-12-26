resource "aws_subnet" "Terraform_Public_Subnet1-testing" {
  vpc_id                  = aws_vpc.Vpc-Terraform.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name    = "Terraform_Public_Subnet1-testing"
    Service = "Terraform"
  }
}