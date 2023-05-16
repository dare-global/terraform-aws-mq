variable "broker_name" {
  type        = string
  description = "Name of the broker"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of VPC subnet IDs"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group IDs assigned to the broker"
  default     = []
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions"
  default     = false
}

variable "deployment_mode" {
  type        = string
  description = "The deployment mode of the broker. Supported: SINGLE_INSTANCE and ACTIVE_STANDBY_MULTI_AZ"
  default     = "ACTIVE_STANDBY_MULTI_AZ"
}

variable "authentication_strategy" {
  type        = string
  description = "Authentication strategy used to secure the broker. Valid values are simple and ldap. ldap is not supported for engine_type RabbitMQ."
  default     = null
}

variable "engine_type" {
  type        = string
  description = "Type of broker engine, `ActiveMQ` or `RabbitMQ`"
  default     = "ActiveMQ"
}

variable "engine_version" {
  type        = string
  description = "The version of the broker engine. See https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/broker-engine.html for more details"
  default     = "5.17.1"
}

variable "host_instance_type" {
  type        = string
  description = "The broker's instance type. e.g. mq.t2.micro or mq.m4.large"
  default     = "mq.t3.micro"
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether to enable connections from applications outside of the VPC that hosts the broker's subnets"
  default     = false
}

variable "general_log_enabled" {
  type        = bool
  description = "Enables general logging via CloudWatch"
  default     = true
}

variable "audit_log_enabled" {
  type        = bool
  description = "Enables audit logging. User management action made using JMX or the ActiveMQ Web Console is logged"
  default     = true
}

variable "maintenance_day_of_week" {
  type        = string
  description = "The maintenance day of the week. e.g. MONDAY, TUESDAY, or WEDNESDAY"
  default     = "SUNDAY"
}

variable "maintenance_time_of_day" {
  type        = string
  description = "The maintenance time, in 24-hour format. e.g. 02:00"
  default     = "03:00"
}

variable "maintenance_time_zone" {
  type        = string
  description = "The maintenance time zone, in either the Country/City format, or the UTC offset format. e.g. CET"
  default     = "UTC"
}

variable "encryption_enabled" {
  type        = bool
  description = "Flag to enable/disable Amazon MQ encryption at rest"
  default     = true
}

variable "kms_mq_key_arn" {
  type        = string
  description = "ARN of the AWS KMS key used for Amazon MQ encryption"
  default     = null
}

variable "use_aws_owned_key" {
  type        = bool
  description = "Boolean to enable an AWS owned Key Management Service (KMS) Customer Master Key (CMK) for Amazon MQ encryption that is not in your account"
  default     = null
}

variable "mq_additional_users" {
  type = list(object({
    username       = string
    password       = string
    groups         = optional(list(string), [])
    console_access = optional(bool, false)
  }))

  description = "Additional MQ users"
  default     = []
}

variable "storage_type" {
  type        = string
  description = "Storage type of the broker. For engine_type ActiveMQ, the valid values are efs and ebs, and the AWS-default is efs. For engine_type RabbitMQ, only ebs is supported. When using ebs, only the mq.m5 broker instance type family is supported."
  default     = null
}

variable "username" {
  type        = string
  description = "Username for the admin user"
  default     = "admin"
}

variable "password" {
  type        = string
  description = "Username for the admin user"
  default     = "adminpass123"
}

variable "configuration_enabled" {
  type        = bool
  description = "Enable configuration block for broker configuration. Applies to engine_type of ActiveMQ only"
  default     = true
}

variable "configuration_data" {
  type        = string
  description = "Broker configuration in XML format"
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "nlb_enabled" {
  description = "Flag to attach Network Load Balancer to Active MQ"
  type        = bool
  default     = false
}

variable "nlb_name" {
  description = "Name of the NLB"
  type        = string
  default     = ""
}

variable "nlb_internal" {
  description = "Scheme type of the NLB, valid value is true or false where true is for internal and false for internet facing"
  type        = bool
  default     = true
}

variable "nlb_subnet_ids" {
  description = "Subnet IDs for the NLB"
  type        = list(string)
  default     = []
}

variable "enable_cross_zone_load_balancing" {
  description = "Flag to enable/disable cross zone load balancing of the NLB"
  type        = bool
  default     = true
}

variable "enable_deletion_protection" {
  description = "Flag to enable/disable deletion of NLB via AWS API and Terraform"
  type        = bool
  default     = false
}

variable "nlb_certificate_arn" {
  description = "Ceritificate ARN of NLB"
  type        = string
  default     = ""

  validation {
    condition     = var.nlb_enabled && var.nlb_certificate_arn == ""
    error_message = "NLB Certificate is mandatory"
  }
}

variable "nlb_tg_port" {
  description = "Target Group Port for NLB"
  type        = number
  default     = 8883
}

variable "nlb_tg_protocol" {
  description = "Target Group Protocol for NLB"
  type        = string
  default     = "TCP"
}
