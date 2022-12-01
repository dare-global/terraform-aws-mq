terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = ">= 4.0.0"
  }
}

provider "aws" {
  region = "eu-west-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  mq_admin_user     = "adminUsername"
  mq_admin_password = "adminPass"
}

module "rabbit_mq" {
  source = "../../"

  broker_name = "my-rabbit-mq-broker"

  subnet_ids = [data.aws_subnets.all.ids[0]]

  engine_type        = "RabbitMQ"
  engine_version     = "3.10.10"
  host_instance_type = "mq.t3.micro"

  apply_immediately = true

  deployment_mode = "SINGLE_INSTANCE"

  encryption_enabled = false

  username = local.mq_admin_user
  password = local.mq_admin_password

  general_log_enabled = true
  audit_log_enabled   = false

  configuration_enabled = false
}
