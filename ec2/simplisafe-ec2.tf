resource "aws_key_pair" "simplisafe-key" {
  key_name   = "steven-levine-simplisafe"
  public_key = "${var.pub_key}"
}

resource "aws_instance" "simplisafe" {
  ami = "ami-07c1207a9d40bc3bd"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.steven_profile.name}"
  vpc_security_group_ids = [aws_security_group.allow_home.id]
  key_name = "${aws_key_pair.simplisafe-key.key_name}"
  user_data = file("userdata.sh")
  tags = {
   Name = "Steven Levine"
  }
}



output "SimpliSafeIP" {
 value = "${aws_instance.simplisafe.public_ip}"
}
