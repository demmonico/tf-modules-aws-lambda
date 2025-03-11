[![License](https://img.shields.io/github/license/demmonico/tf-modules-aws-lambda)](LICENSE)
[![Tests](https://github.com/demmonico/tf-modules-aws-lambda/actions/workflows/tests.yml/badge.svg)](https://github.com/demmonico/tf-modules-aws-lambda/actions/workflows/tests.yml)
![GitHub Tag](https://img.shields.io/github/v/tag/demmonico/tf-modules-aws-lambda)

# Terraform Modules Template

Bootstraps a new Terraform module repo.

## Usage

```terraform
module "lambda" {
  source = "git::https://github.com/demmonico/tf-modules-aws-lambda.git?ref=1.0.0"

  lambda_name               = local.lambda_name
  cw_logs_retention_in_days = var.lambdas_cw_logs_retention_in_days
  dlq_enabled               = false

  secrets_config = [{
    secret_name = local.lambda_name
    secret_keys = [
      "ORG_ID",
      "TOKEN",
      "API_URL",
    ]
  }]
}
```

## Development

Steps:
- run `make init` to initialize the repo and hooks (see [Initialize the repo](#initialize-the-repo) section)

### Initialize the repo

```shell
make init
```


### Run tests

It triggers git pre-commit hooks

```shell
make test
```


# Auto-generated specs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.7.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret"></a> [secret](#module\_secret) | git::https://github.com/demmonico/tf-modules-aws-sm-secret.git | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.cwlogs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.dlq_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.invoke_on_failure_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.invoke_on_success_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cwlogs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.dlq_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.invoke_on_failure_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.invoke_on_success_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vpc_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_sqs_queue.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [archive_file.lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cw_log_group_name"></a> [cw\_log\_group\_name](#input\_cw\_log\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_cw_log_group_policy_name"></a> [cw\_log\_group\_policy\_name](#input\_cw\_log\_group\_policy\_name) | n/a | `string` | `""` | no |
| <a name="input_cw_logs_retention_in_days"></a> [cw\_logs\_retention\_in\_days](#input\_cw\_logs\_retention\_in\_days) | n/a | `number` | `7` | no |
| <a name="input_dlq_enabled"></a> [dlq\_enabled](#input\_dlq\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_dlq_kms_data_key_reuse_period"></a> [dlq\_kms\_data\_key\_reuse\_period](#input\_dlq\_kms\_data\_key\_reuse\_period) | Number of seconds to reuse KMS data key | `number` | `300` | no |
| <a name="input_dlq_max_msg_size"></a> [dlq\_max\_msg\_size](#input\_dlq\_max\_msg\_size) | Max size of the message in bytes | `number` | `262144` | no |
| <a name="input_dlq_name"></a> [dlq\_name](#input\_dlq\_name) | n/a | `string` | `""` | no |
| <a name="input_dlq_retention"></a> [dlq\_retention](#input\_dlq\_retention) | Number of seconds to retain a message | `number` | `604800` | no |
| <a name="input_dlq_visibility_timeout"></a> [dlq\_visibility\_timeout](#input\_dlq\_visibility\_timeout) | Timeout for message visibility in seconds | `number` | `30` | no |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | n/a | `string` | `"index.handler"` | no |
| <a name="input_lambda_max_retry_attempts"></a> [lambda\_max\_retry\_attempts](#input\_lambda\_max\_retry\_attempts) | n/a | `number` | `2` | no |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | n/a | `number` | `128` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | n/a | `string` | n/a | yes |
| <a name="input_lambda_on_failure_destination"></a> [lambda\_on\_failure\_destination](#input\_lambda\_on\_failure\_destination) | n/a | `string` | `null` | no |
| <a name="input_lambda_on_failure_destination_enabled"></a> [lambda\_on\_failure\_destination\_enabled](#input\_lambda\_on\_failure\_destination\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_lambda_on_success_destination"></a> [lambda\_on\_success\_destination](#input\_lambda\_on\_success\_destination) | n/a | `string` | `null` | no |
| <a name="input_lambda_on_success_destination_enabled"></a> [lambda\_on\_success\_destination\_enabled](#input\_lambda\_on\_success\_destination\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_lambda_reserved_concurrent_executions"></a> [lambda\_reserved\_concurrent\_executions](#input\_lambda\_reserved\_concurrent\_executions) | Amount of reserved concurrent executions for this lambda function ('0' - disable lambda, '-1' - unlimited) | `number` | `-1` | no |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | n/a | `string` | `"nodejs20.x"` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | n/a | `number` | `900` | no |
| <a name="input_resource_name_prefix"></a> [resource\_name\_prefix](#input\_resource\_name\_prefix) | n/a | `string` | `""` | no |
| <a name="input_secrets_config"></a> [secrets\_config](#input\_secrets\_config) | n/a | <pre>list(object({<br/>    secret_name = string<br/>    secret_keys = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | n/a | <pre>object({<br/>    subnet_ids         = list(string)<br/>    security_group_ids = list(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | n/a |
| <a name="output_lambda_invoke_arn"></a> [lambda\_invoke\_arn](#output\_lambda\_invoke\_arn) | n/a |
| <a name="output_lambda_name"></a> [lambda\_name](#output\_lambda\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
