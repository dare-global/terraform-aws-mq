data "aws_subnet" "main" {
  id = var.subnet_ids[0]
}
