resource "aws_s3_bucket" "ajay00001" {
  bucket = "ajay00001"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  depends_on = [ aws_route_table_association.Pub-RTA-Terraform ]
}

resource "aws_s3_bucket" "ajay00002" {
  bucket = "ajay00002"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  depends_on = [ aws_s3_bucket.ajay00001 ]
}

resource "aws_s3_bucket" "ajay00003" {
  bucket = "ajay00003"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  depends_on = [ aws_s3_bucket.ajay00001 ]
}