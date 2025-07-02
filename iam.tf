#---------------------------#
# IAM Role

resource "aws_iam_role" "this" {
  max_session_duration = 3600 // 1 hour
  name                 = "${local.resource_name_prefix}-role"
  path                 = "/"
  assume_role_policy   = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Principal": {
              "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
      }
  ]
}
POLICY
}

# Policies allowing invoke destination config Lambda

resource "aws_iam_policy" "invoke_on_success_policy" {
  count = var.lambda_on_success_destination_enabled ? 1 : 0

  name        = "${local.resource_name_prefix}-invoke-onsuccess"
  path        = "/"
  description = "Policy that allows invoke destination config Lambda"

  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "lambda:InvokeFunction"
                ],
                "Resource": [
                    "${var.lambda_on_success_destination}",
                    "${var.lambda_on_success_destination}:*"
                ]
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "invoke_on_success_attachment" {
  count = var.lambda_on_success_destination_enabled ? 1 : 0

  policy_arn = aws_iam_policy.invoke_on_success_policy[0].arn
  role       = aws_iam_role.this.name
}

resource "aws_iam_policy" "invoke_on_failure_policy" {
  count = var.lambda_on_failure_destination_enabled ? 1 : 0

  name        = "${local.resource_name_prefix}-invoke-onfailure"
  path        = "/"
  description = "Policy that allows invoke destination config Lambda"

  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "lambda:InvokeFunction"
                ],
                "Resource": [
                    "${var.lambda_on_failure_destination}",
                    "${var.lambda_on_failure_destination}:*"
                ]
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "invoke_on_failure_attachment" {
  count = var.lambda_on_failure_destination_enabled ? 1 : 0

  policy_arn = aws_iam_policy.invoke_on_failure_policy[0].arn
  role       = aws_iam_role.this.name
}

# Policies allowing work from the VPC
resource "aws_iam_role_policy_attachment" "vpc_attachment" {
  count = var.vpc_config != null ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  role       = aws_iam_role.this.name
}

# Additional policy ARNs to be attached

resource "aws_iam_role_policy_attachment" "additional_policies" {
  for_each = var.role_additional_policy_arns == null ? {} : var.role_additional_policy_arns

  policy_arn = each.value
  role       = aws_iam_role.this.name
}
