resource "aws_lb" "main" {
  count = var.nlb_enabled && var.deployment_mode == "ACTIVE_STANDBY_MULTI_AZ" ? 1 : 0

  name               = var.nlb_name == null ? "${var.broker_name}-nlb" : var.nlb_name
  internal           = var.nlb_internal
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection

  tags = merge(var.nlb_tags, var.tags)

  depends_on = [
    aws_mq_broker.main,
  ]
}

resource "aws_lb_target_group" "main" {
  count = var.nlb_enabled && var.deployment_mode == "ACTIVE_STANDBY_MULTI_AZ" ? 1 : 0

  name        = aws_lb.main[0].name
  port        = var.nlb_tg_port
  protocol    = var.nlb_tg_protocol
  target_type = "ip"
  vpc_id      = data.aws_subnet.main.vpc_id

  health_check {
    enabled           = true
    port              = 8162
    protocol          = "TCP"
    interval          = 10
    healthy_threshold = 3
  }

  depends_on = [
    aws_lb.main,
  ]
}

resource "aws_lb_target_group_attachment" "main" {
  count = (var.nlb_enabled && var.deployment_mode == "ACTIVE_STANDBY_MULTI_AZ") ? length(var.subnet_ids) : 0

  target_group_arn = aws_lb_target_group.main[0].arn
  target_id        = aws_mq_broker.main.instances[count.index]["ip_address"]
  port             = 8883

  depends_on = [
    aws_mq_broker.main,
  ]
}

resource "aws_lb_listener" "main" {
  count = var.nlb_enabled && var.deployment_mode == "ACTIVE_STANDBY_MULTI_AZ" ? 1 : 0

  load_balancer_arn = aws_lb.main[0].arn
  port              = "8883"
  protocol          = "TLS"
  certificate_arn   = var.nlb_certificate_arn
  alpn_policy       = "HTTP2Preferred"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[0].arn
  }

  depends_on = [
    aws_lb.main,
  ]
}
