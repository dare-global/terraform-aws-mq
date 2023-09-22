locals {
  mq_logs = {
    logs = {
      "general_log_enabled" : var.general_log_enabled,
      "audit_log_enabled" : var.audit_log_enabled
    }
  }
}

resource "aws_mq_broker" "main" {
  broker_name = var.broker_name

  deployment_mode    = var.deployment_mode
  engine_type        = var.engine_type
  engine_version     = var.engine_version
  host_instance_type = var.host_instance_type
  storage_type       = var.storage_type

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  publicly_accessible = var.publicly_accessible

  subnet_ids = var.subnet_ids

  tags = var.tags

  authentication_strategy = var.authentication_strategy

  security_groups = var.create_security_group ? concat(var.security_groups, [aws_security_group.main[0].id]) : var.security_groups

  dynamic "configuration" {
    for_each = var.configuration_enabled ? ["true"] : []
    content {
      id       = aws_mq_configuration.main[0].id
      revision = aws_mq_configuration.main[0].latest_revision
    }
  }

  dynamic "encryption_options" {
    for_each = var.encryption_enabled ? ["true"] : []
    content {
      kms_key_id        = var.kms_mq_key_arn
      use_aws_owned_key = var.use_aws_owned_key
    }
  }

  dynamic "logs" {
    for_each = {
      for logs, type in local.mq_logs : logs => type
      if type.general_log_enabled || type.audit_log_enabled
    }
    content {
      general = logs.value["general_log_enabled"]
      audit   = logs.value["audit_log_enabled"]
    }
  }

  maintenance_window_start_time {
    day_of_week = var.maintenance_day_of_week
    time_of_day = var.maintenance_time_of_day
    time_zone   = var.maintenance_time_zone
  }

  dynamic "user" {
    for_each = { for user in var.mq_additional_users : user.username => user }
    content {
      username       = user.value.username
      password       = user.value.password
      groups         = user.value.groups
      console_access = user.value.console_access
    }
  }

  user {
    username       = var.username
    password       = var.password
    groups         = ["admin"]
    console_access = true
  }
}

resource "aws_mq_configuration" "main" {
  count = var.configuration_enabled ? 1 : 0

  name = var.broker_name
  data = var.configuration_data

  engine_type             = var.engine_type
  engine_version          = var.engine_version
  authentication_strategy = var.authentication_strategy
  description             = "Custom MQ configuration"
  tags                    = var.tags
}
