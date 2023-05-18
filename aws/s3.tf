resource "aws_s3_bucket" "example" {
  bucket = "bucket${var.name}${random_string.this.result}"

  tags = {
    Name    = "bucket${var.name}${random_string.this.result}"
    Project = random_string.this.result
  }
}
