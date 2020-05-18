resource "aws_key_pair" "upvote-downvote-key" {
  key_name   = "upvote-downvote-ssh-key"
  public_key = "${file(var.public_key)}"
}

resource "aws_instance" "upvote-downvote" {
  ami = "ami-07c1207a9d40bc3bd" #Ubuntu
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.steven_profile.name}"
  vpc_security_group_ids = [aws_security_group.allow_home_ip.id]
  key_name = "${aws_key_pair.upvote-downvote-key.key_name}"
  user_data = templatefile("userdata.tpl", {user_data_bucket_name = var.bucket_name}) #v0.12 and later
  #user_data = "${data.template_file.user_data_tpl.rendered}" #v0.11 and earlier
  depends_on = [aws_s3_bucket_object.python_object]
  tags = {
   Name = "upvote-downvote"
   Environment = "terraform-created"
  }
}

#Required for v0.11 and earlier
/* Commenting Out
data "template_file" "user_data_tpl" {
  template = file("userdata.tpl")
  vars = {
    user_data_bucket_name = "${var.bucket_name}"
  }
}
*/

output "upvote-downvote_public_IP" {
 value = "${aws_instance.upvote-downvote.public_ip}"
}
