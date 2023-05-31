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
  id = "vpc-03eec2463877cec00"
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

locals {
  mq_admin_user     = "adminUsername"
  mq_admin_password = "adminPassword"
}

module "active_mq" {
  source = "../../"

  broker_name = "my-active-mq-broker"

  subnet_ids = data.aws_subnets.all.ids

  engine_type        = "ActiveMQ"
  engine_version     = "5.17.2"
  host_instance_type = "mq.t3.micro"

  apply_immediately = true

  deployment_mode = "ACTIVE_STANDBY_MULTI_AZ"

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

  nlb_enabled = true
  #  nlb_certificate_arn = "arn:aws:acm:eu-west-2:837520006200:certificate/dfeb4699-f8f1-4cc5-b1bc-21c9694c650b"

  create_security_group      = true
  security_group_name        = "example"
  security_group_description = "example"
  cidr_blocks_8883           = [data.aws_vpc.default.cidr_block]
  prefix_lists_8883          = [data.aws_ec2_managed_prefix_list.asset_control_vpn_office_cidrs.id]
}

data "aws_ec2_managed_prefix_list" "asset_control_vpn_office_cidrs" {
  name = "com.amazonaws.eu-west-2.s3"
}
