locals {
  dlq_name = var.dlq_name != "" ? var.dlq_name : "${local.resource_name_prefix}-DLQ"
}

resource "aws_sqs_queue" "dlq" {
  count = var.dlq_enabled ? 1 : 0

  name                              = local.dlq_name
  message_retention_seconds         = var.dlq_retention
  kms_data_key_reuse_period_seconds = var.dlq_kms_data_key_reuse_period
  max_message_size                  = var.dlq_max_msg_size

  sqs_managed_sse_enabled    = true
  visibility_timeout_seconds = var.dlq_visibility_timeout
}

resource "aws_iam_policy" "dlq_policy" {
  count = var.dlq_enabled ? 1 : 0

  name        = "${local.dlq_name}-policy"
  path        = "/"
  description = "Policy that allows send message to the DLQ"

  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "sqs:SendMessage",
                "Resource": "${aws_sqs_queue.dlq[0].arn}"
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "dlq_policy" {
  count = var.dlq_enabled ? 1 : 0

  policy_arn = aws_iam_policy.dlq_policy[0].arn
  role       = aws_iam_role.this.name
}
