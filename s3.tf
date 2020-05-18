resource "aws_s3_bucket" "python_code_bucket" {
  bucket = "${var.bucket_name}"
  acl    = "private"
  force_destroy = true #Danger

  tags = {
    Name        = "${var.bucket_name}"
    Environment = "terraform-created"
  }
}

resource "aws_s3_bucket_object" "python_object" {
  bucket = aws_s3_bucket.python_code_bucket.bucket
  key    = "web.py"
  source = "${var.code_path}"
  etag = "${filemd5(var.code_path)}"
  server_side_encryption = "aws:kms"
}