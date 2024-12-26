provider "aws" {
  region = var.region_name
}

resource "aws_vpc" "Vpc-Terraform" {
  cidr_block           = var.Vpc_cidr_block
  enable_dns_hostnames = "true"

  tags = {
    Name    = var.vpc_tag
    Service = "Terraform"
  }
}

resource "aws_internet_gateway" "Igw-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  tags = {
    Name    = var.igw_tag
    Service = "Terraform"
  }
}

resource "aws_subnet" "Terraform_Public_Subnet1-testing" {
  vpc_id                  = aws_vpc.Vpc-Terraform.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.subnet_az

  tags = {
    Name    = var.subnet_tag
    Service = "Terraform"
  }
}

# Route Table
resource "aws_route_table" "Pub-RT-Terraform" {
  vpc_id = aws_vpc.Vpc-Terraform.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.Igw-Terraform.id
  }

  tags = {
    Name    = "Pub-RT-Terraform"
    Service = "Terraform"
  }
}

# Subnet Association
resource "aws_route_table_association" "Pub-RTA-Terraform" {
  subnet_id      = aws_subnet.Terraform_Public_Subnet1-testing.id
  route_table_id = aws_route_table.Pub-RT-Terraform.id
}


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Vpc-Terraform.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "allow_all"
    Service = "Terraform"
  }
}

resource "aws_instance" "web-1" {
  ami                         = "ami-0e2c8caa4b6378d8c"
  availability_zone           = var.ec2_az
  instance_type               = var.instance_type
  key_name                    = "barfi"
  subnet_id                   = aws_subnet.Terraform_Public_Subnet1-testing.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Prod-Server"
    Env        = "Prod"
    CostCenter = "ABCD"
  }
}
 