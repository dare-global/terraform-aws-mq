# terraform-aws-mq
Terraform module for provisioning an Amazon MQ broker

## Usage

```hcl
module "mq" {
  source  = "dare-global/mq/aws"
  version = "1.X.X"

  broker_name = "mq-broker"
  subnet_ids = ["subnet-id-12345"]
}
```

## Examples

* [ActiveMQ](https://github.com/dare-global/terraform-aws-mq/tree/main/examples/activemq)
* [RabbitMQ](https://github.com/dare-global/terraform-aws-mq/tree/main/examples/rabbitmq)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_mq_broker.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker) | resource |
| [aws_mq_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window | `bool` | `false` | no |
| <a name="input_audit_log_enabled"></a> [audit\_log\_enabled](#input\_audit\_log\_enabled) | Enables audit logging. User management action made using JMX or the ActiveMQ Web Console is logged | `bool` | `true` | no |
| <a name="input_authentication_strategy"></a> [authentication\_strategy](#input\_authentication\_strategy) | Authentication strategy used to secure the broker. Valid values are simple and ldap. ldap is not supported for engine\_type RabbitMQ. | `string` | `null` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions | `bool` | `false` | no |
| <a name="input_broker_name"></a> [broker\_name](#input\_broker\_name) | Name of the broker | `string` | n/a | yes |
| <a name="input_configuration_data"></a> [configuration\_data](#input\_configuration\_data) | Broker configuration in XML format | `string` | `null` | no |
| <a name="input_configuration_enabled"></a> [configuration\_enabled](#input\_configuration\_enabled) | Enable configuration block for broker configuration. Applies to engine\_type of ActiveMQ only | `bool` | `true` | no |
| <a name="input_deployment_mode"></a> [deployment\_mode](#input\_deployment\_mode) | The deployment mode of the broker. Supported: SINGLE\_INSTANCE and ACTIVE\_STANDBY\_MULTI\_AZ | `string` | `"ACTIVE_STANDBY_MULTI_AZ"` | no |
| <a name="input_encryption_enabled"></a> [encryption\_enabled](#input\_encryption\_enabled) | Flag to enable/disable Amazon MQ encryption at rest | `bool` | `true` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | Type of broker engine, `ActiveMQ` or `RabbitMQ` | `string` | `"ActiveMQ"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the broker engine. See https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/broker-engine.html for more details | `string` | `"5.17.1"` | no |
| <a name="input_general_log_enabled"></a> [general\_log\_enabled](#input\_general\_log\_enabled) | Enables general logging via CloudWatch | `bool` | `true` | no |
| <a name="input_host_instance_type"></a> [host\_instance\_type](#input\_host\_instance\_type) | The broker's instance type. e.g. mq.t2.micro or mq.m4.large | `string` | `"mq.t3.micro"` | no |
| <a name="input_kms_mq_key_arn"></a> [kms\_mq\_key\_arn](#input\_kms\_mq\_key\_arn) | ARN of the AWS KMS key used for Amazon MQ encryption | `string` | `null` | no |
| <a name="input_maintenance_day_of_week"></a> [maintenance\_day\_of\_week](#input\_maintenance\_day\_of\_week) | The maintenance day of the week. e.g. MONDAY, TUESDAY, or WEDNESDAY | `string` | `"SUNDAY"` | no |
| <a name="input_maintenance_time_of_day"></a> [maintenance\_time\_of\_day](#input\_maintenance\_time\_of\_day) | The maintenance time, in 24-hour format. e.g. 02:00 | `string` | `"03:00"` | no |
| <a name="input_maintenance_time_zone"></a> [maintenance\_time\_zone](#input\_maintenance\_time\_zone) | The maintenance time zone, in either the Country/City format, or the UTC offset format. e.g. CET | `string` | `"UTC"` | no |
| <a name="input_mq_additional_users"></a> [mq\_additional\_users](#input\_mq\_additional\_users) | Additional MQ users | <pre>list(object({<br>    username       = string<br>    password       = string<br>    groups         = optional(list(string), [])<br>    console_access = optional(bool, false)<br>  }))</pre> | `[]` | no |
| <a name="input_password"></a> [password](#input\_password) | Username for the admin user | `string` | `"adminpass123"` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Whether to enable connections from applications outside of the VPC that hosts the broker's subnets | `bool` | `false` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security group IDs assigned to the broker | `list(string)` | `[]` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Storage type of the broker. For engine\_type ActiveMQ, the valid values are efs and ebs, and the AWS-default is efs. For engine\_type RabbitMQ, only ebs is supported. When using ebs, only the mq.m5 broker instance type family is supported. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of VPC subnet IDs | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| <a name="input_use_aws_owned_key"></a> [use\_aws\_owned\_key](#input\_use\_aws\_owned\_key) | Boolean to enable an AWS owned Key Management Service (KMS) Customer Master Key (CMK) for Amazon MQ encryption that is not in your account | `bool` | `null` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the admin user | `string` | `"admin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_broker_arn"></a> [broker\_arn](#output\_broker\_arn) | AmazonMQ broker ARN. |
| <a name="output_broker_id"></a> [broker\_id](#output\_broker\_id) | AmazonMQ broker ID. |
| <a name="output_broker_instances"></a> [broker\_instances](#output\_broker\_instances) | AmazonMQ broker instances details. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

See LICENSE file for full details.

## Maintainers

* [Marcin Cuber](https://github.com/marcincuber)

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
