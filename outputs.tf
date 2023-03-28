output "broker_id" {
  value       = aws_mq_broker.main.id
  description = "AmazonMQ broker ID."
}

output "broker_arn" {
  value       = aws_mq_broker.main.arn
  description = "AmazonMQ broker ARN."
}

output "broker_ips" {
  value       = aws_mq_broker.main.instances.0.ip_address
  description = "AmazonMQ broker ARN."
}
