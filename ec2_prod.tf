resource "aws_instance" "web-1" {
  ami                         = "ami-0e2c8caa4b6378d8c"
  availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
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
 