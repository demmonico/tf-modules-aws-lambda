locals {
  cw_log_group_name        = var.cw_log_group_name != "" ? var.cw_log_group_name : "/aws/lambda/${local.resource_name_prefix}"
  cw_log_group_policy_name = var.cw_log_group_policy_name != "" ? var.cw_log_group_policy_name : "${local.resource_name_prefix}-cwlogs-policy"
}

resource "aws_cloudwatch_log_group" "this" {
  name              = local.cw_log_group_name
  retention_in_days = var.cw_logs_retention_in_days
}

resource "aws_iam_policy" "cwlogs_policy" {
  name        = local.cw_log_group_policy_name
  path        = "/"
  description = "Policy that allows put data for CloudWatch Logs"

  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ],
                "Resource": [
                    "${aws_cloudwatch_log_group.this.arn}:*",
                    "${aws_cloudwatch_log_group.this.arn}:*:*"
                ]
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "cwlogs_policy" {
  policy_arn = aws_iam_policy.cwlogs_policy.arn
  role       = aws_iam_role.this.name
}
