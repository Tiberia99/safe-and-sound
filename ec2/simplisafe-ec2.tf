resource "aws_key_pair" "steven-levine" {
  key_name   = "steven-levine-simplisafe"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFklCryyHOQhZ7RsjWeDtRa1xrHK+JR2UY3xUW+8V/38hG0wGxwm/g12Ha6c6ni5H2IO2ogwcWsCalFbTcoJ+Tqjj8HCriYY4W/boULKeQYm7Tm2k6FtdcUz5hx4fO7Pafv5aB/TIry+duVwuAVjPQ5o/JRbCJ1V3aBGv63Ci5Pb9cf7h9u2KdN/X8tGisfocmrkzCFNYBlcChM4AeE1cM1D88n9CqGds7KSk2e1857eIEAA/pQgRVITGiMXxVx1tC95plg0Fka5gmZYdepcOvJEM7ZbxUKXiz40E3HbO+cVzKU1mbGAGq2wR1qkV1arQfojoF2fHU7+FUbxD/ICH/jbiLj/HPHAtusnOcvtd4J6kahDL8rBug9Ets8FMl/r9JVEWzXCHoF6/fRrINMSXY1gpC6AgUahfWvaQkx/lYHCf7R/Nv6jHoGql6F9oVKzpLbcgdsVas6NN22ua+j4Gqv8AReF7tUwHwpt1E1HF90PwbSpHfQfJAwfRvkrmWJDBD6lXXmJckYYeIaiL9DwiFg3DSW+OAv0cb7f16tkwWYwvtx2MN3jY6eMgf9+Z1SSnVrk3Jpcm/Ss1uLFsKrCTueB6l6MLZvpBJ+6wbIgIAYK+eo9RASWYy4kwYMdPMFj0Q4MTD+7NEABr2ugEu60JXnKFi6/yGPer2cDT0DU9aTw== steven-levine-simplisafe"
}

resource "aws_instance" "simplisafe" {
  ami = "ami-07c1207a9d40bc3bd"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.steven_profile.name}"
  vpc_security_group_ids = [aws_security_group.allow_home.id]
  key_name = "${aws_key_pair.steven-levine.key_name}"
  user_data = file("userdata.sh")
  tags = {
   Name = "Steven Levine"
  }
}



output "SimpliSafeIP" {
 value = "${aws_instance.simplisafe.public_ip}"
}
