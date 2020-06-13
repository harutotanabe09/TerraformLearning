# Create a new ECR
resource "aws_ecr_repository" "onboard_dev" {
  name                 = "onboard_dev_name"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "Terraform"
  }
}