terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = ">= 5.0.0"
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

module "active_mq" {
  source = "../../"

  broker_name = "my-active-mq-broker"

  subnet_ids = [data.aws_subnets.all.ids[0]]

  engine_type        = "ActiveMQ"
  engine_version     = "5.17.2"
  host_instance_type = "mq.t3.micro"

  apply_immediately = true

  deployment_mode = "SINGLE_INSTANCE"

  encryption_enabled = false

  username = local.mq_admin_user
  password = local.mq_admin_password

  general_log_enabled = true
  audit_log_enabled   = true

  configuration_data = <<DATA
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<broker xmlns="http://activemq.apache.org/schema/core">
  <plugins>
    <forcePersistencyModeBrokerPlugin persistenceFlag="true"/>
    <statisticsBrokerPlugin/>
    <timeStampingBrokerPlugin ttlCeiling="86400000" zeroExpirationOverride="86400000"/>
  </plugins>
</broker>
DATA
}
