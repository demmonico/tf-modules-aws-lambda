locals {
  resource_name_prefix = var.resource_name_prefix != "" ? var.resource_name_prefix : var.lambda_name

  lambda_code_templates_map = {
    "python" = "lambda-py-code-template"
    "nodejs" = "lambda-js-code-template" // default
  }
  lambda_code_template_name = startswith(var.lambda_runtime, "python") ? local.lambda_code_templates_map.python : local.lambda_code_templates_map.nodejs
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/${local.lambda_code_template_name}"
  output_path = "${var.lambda_name}.zip"
}

#---------------------------#
# Lambda

resource "aws_lambda_function" "this" {
  function_name = var.lambda_name
  filename      = "${var.lambda_name}.zip"
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = aws_iam_role.this.arn

  memory_size                    = var.lambda_memory_size
  timeout                        = var.lambda_timeout
  reserved_concurrent_executions = var.lambda_reserved_concurrent_executions

  tracing_config {
    mode = "PassThrough"
  }

  source_code_hash = data.archive_file.lambda.output_base64sha256

  dynamic "dead_letter_config" {
    for_each = var.dlq_enabled ? toset([1]) : toset([])

    content {
      target_arn = aws_sqs_queue.dlq[0].arn
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? toset([1]) : toset([])

    content {
      subnet_ids         = var.vpc_config.subnet_ids
      security_group_ids = var.vpc_config.security_group_ids
    }
  }

  lifecycle {
    ignore_changes = [source_code_hash, environment]
  }
}

resource "aws_lambda_function_event_invoke_config" "this" {
  function_name = aws_lambda_function.this.function_name

  maximum_retry_attempts = var.lambda_max_retry_attempts

  dynamic "destination_config" {
    for_each = var.lambda_on_success_destination_enabled || var.lambda_on_failure_destination_enabled ? toset([1]) : toset([])

    content {
      dynamic "on_success" {
        for_each = var.lambda_on_success_destination_enabled ? toset([1]) : toset([])

        content {
          destination = var.lambda_on_success_destination
        }
      }

      dynamic "on_failure" {
        for_each = var.lambda_on_failure_destination_enabled ? toset([1]) : toset([])

        content {
          destination = var.lambda_on_failure_destination
        }
      }
    }
  }
}

