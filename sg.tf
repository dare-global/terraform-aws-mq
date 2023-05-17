resource "aws_security_group" "main" {
  count = var.create_security_group ? 1 : 0

  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = data.aws_subnet.main.vpc_id

  revoke_rules_on_delete = var.revoke_rules_on_delete

  tags = merge(var.tags, var.security_group_tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "cidr_blocks_8883" {
  count = var.create_security_group && length(var.cidr_blocks_8883) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  cidr_blocks       = var.cidr_blocks_8883
  description       = "Cidr Blocks for MQTT"
  from_port         = 8883
  to_port           = 8883
  protocol          = "tcp"
}

resource "aws_security_group_rule" "prefix_lists_8883" {
  count = var.create_security_group && length(var.prefix_lists_8883) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  prefix_list_ids   = var.prefix_lists_8883
  description       = "Prefix Lists for MQTT"
  from_port         = 8883
  to_port           = 8883
  protocol          = "tcp"
}

resource "aws_security_group_rule" "cidr_blocks_8162" {
  count = var.create_security_group && length(var.cidr_blocks_8162) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  cidr_blocks       = var.cidr_blocks_8162
  description       = "Cidr Blocks for Amazon MQ for ActiveMQ console"
  from_port         = 8162
  to_port           = 8162
  protocol          = "tcp"
}

resource "aws_security_group_rule" "prefix_lists_8162" {
  count = var.create_security_group && length(var.prefix_lists_8162) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  prefix_list_ids   = var.prefix_lists_8162
  description       = "Prefix Lists for Amazon MQ for ActiveMQ console"
  from_port         = 8162
  to_port           = 8162
  protocol          = "tcp"
}

resource "aws_security_group_rule" "cidr_blocks_61619" {
  count = var.create_security_group && length(var.cidr_blocks_61619) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  cidr_blocks       = var.cidr_blocks_61619
  description       = "Cidr Blocks for ActiveMQ Websocket"
  from_port         = 61619
  to_port           = 61619
  protocol          = "tcp"
}

resource "aws_security_group_rule" "prefix_lists_61619" {
  count = var.create_security_group && length(var.prefix_lists_61619) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  prefix_list_ids   = var.prefix_lists_61619
  description       = "Prefix Lists for ActiveMQ Websocket"
  from_port         = 61619
  to_port           = 61619
  protocol          = "tcp"
}

resource "aws_security_group_rule" "cidr_blocks_5671" {
  count = var.create_security_group && length(var.cidr_blocks_5671) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  cidr_blocks       = var.cidr_blocks_5671
  description       = "Cidr block for connections made via SSL AMQP"
  from_port         = 5671
  to_port           = 5671
  protocol          = "tcp"
}

resource "aws_security_group_rule" "prefix_lists_5671" {
  count = var.create_security_group && length(var.prefix_lists_5671) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  prefix_list_ids   = var.prefix_lists_5671
  description       = "Prefix Lists for connections made via SSL AMQP"
  from_port         = 5671
  to_port           = 5671
  protocol          = "tcp"
}

resource "aws_security_group_rule" "cidr_blocks_443" {
  count = var.create_security_group && length(var.cidr_blocks_443) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  cidr_blocks       = var.cidr_blocks_443
  description       = "Cidr Blocks for Amazon MQ RabbitMQ console"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
}

resource "aws_security_group_rule" "prefix_lists_443" {
  count = var.create_security_group && length(var.prefix_lists_443) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  prefix_list_ids   = var.prefix_lists_443
  description       = "Prefix Lists for Amazon MQ RabbitMQ console"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
}

resource "aws_security_group_rule" "cidr_blocks_15671" {
  count = var.create_security_group && length(var.cidr_blocks_15671) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  cidr_blocks       = var.cidr_blocks_15671
  description       = "Cidr blocks for Amazon MQ RabbitMQ console"
  from_port         = 15671
  to_port           = 15671
  protocol          = "tcp"
}

resource "aws_security_group_rule" "prefix_lists_15671" {
  count = var.create_security_group && length(var.prefix_lists_15671) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  prefix_list_ids   = var.prefix_lists_15671
  description       = "Prefix Lists for Amazon MQ RabbitMQ console"
  from_port         = 15671
  to_port           = 15671
  protocol          = "tcp"
}

resource "aws_security_group_rule" "cidr_blocks_61617" {
  count = var.create_security_group && length(var.cidr_blocks_61617) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  cidr_blocks       = var.cidr_blocks_61617
  description       = "Cidr block for Amazon MQ SSL"
  from_port         = 61617
  to_port           = 61617
  protocol          = "tcp"
}

resource "aws_security_group_rule" "prefix_lists_61617" {
  count = var.create_security_group && length(var.prefix_lists_61617) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  prefix_list_ids   = var.prefix_lists_61617
  description       = "Prefix Lists for Amazon MQ SSL"
  from_port         = 61617
  to_port           = 61617
  protocol          = "tcp"
}

resource "aws_security_group_rule" "cidr_blocks_61614" {
  count = var.create_security_group && length(var.cidr_blocks_61614) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  cidr_blocks       = var.cidr_blocks_61614
  description       = "Cidr block for Amazon MQ Stomp + SSL"
  from_port         = 61614
  to_port           = 61614
  protocol          = "tcp"
}

resource "aws_security_group_rule" "prefix_lists_61614" {
  count = var.create_security_group && length(var.prefix_lists_61614) > 0 ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.main[0].id
  prefix_list_ids   = var.prefix_lists_61614
  description       = "Prefix Lists for Amazon MQ Stomp + SSL"
  from_port         = 61614
  to_port           = 61614
  protocol          = "tcp"
}

resource "aws_security_group_rule" "main" {
  count = var.create_security_group ? 1 : 0

  type              = "egress"
  description       = "Egress Rule for ${aws_mq_broker.main.broker_name}"
  protocol          = "-1"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main[0].id
}
