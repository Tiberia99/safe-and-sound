resource "aws_s3_bucket" "b" {
  bucket = "steven-levine-simpli-safe-interview-test"
  acl    = "private"
  force_destroy = true #Danger!

  tags = {
    Name        = "steven-levine-simpli-safe-interview-test"
    Environment = "Interview"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.b.bucket
  key    = "getip.py"
  source = "${var.code_path}"
  etag = "${filemd5(var.code_path)}"
  server_side_encryption = "aws:kms"
  
}