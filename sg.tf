resource "aws_default_vpc" "default" {
  tags = {
    Name = "Steven Default VPC"
  }
}


resource "aws_security_group" "allow_home_ip" {
  name        = "allow_home_ip"
  description = "Allow home IP inbound traffic"
  vpc_id      = "${aws_default_vpc.default.id}"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.home_ip}"]
  }
  
  ingress {
    description = "PythonFlask"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["${var.home_ip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_home_ip"
  }
}