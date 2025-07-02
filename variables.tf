variable "resource_name_prefix" {
  type    = string
  default = ""
}

#---------------------------#

variable "lambda_name" {
  type = string
}

variable "lambda_handler" {
  type    = string
  default = "index.handler"
}

variable "lambda_runtime" {
  type    = string
  default = "nodejs20.x"
}

variable "lambda_memory_size" {
  type    = number
  default = 128 // 128 MB
}

variable "lambda_timeout" {
  type    = number
  default = 900 // 15 minutes
}

variable "lambda_reserved_concurrent_executions" {
  type        = number
  default     = -1 // unlimited
  description = "Amount of reserved concurrent executions for this lambda function ('0' - disable lambda, '-1' - unlimited)"
}

variable "lambda_max_retry_attempts" {
  type    = number
  default = 2
}

variable "lambda_on_success_destination_enabled" {
  type    = bool
  default = false
}
variable "lambda_on_success_destination" {
  type    = string
  default = null
}

variable "lambda_on_failure_destination_enabled" {
  type    = bool
  default = false
}
variable "lambda_on_failure_destination" {
  type    = string
  default = null
}

#---------------------------#

variable "role_additional_policy_arns" {
  type    = map(string)
  default = null
}

#---------------------------#

variable "cw_log_group_name" {
  type    = string
  default = ""
}

variable "cw_log_group_policy_name" {
  type    = string
  default = ""
}

variable "cw_logs_retention_in_days" {
  type    = number
  default = 7
}

#---------------------------#

variable "dlq_enabled" {
  type    = bool
  default = true
}

variable "dlq_name" {
  type    = string
  default = ""
}

variable "dlq_retention" {
  type        = number
  default     = 604800 // 7 days
  description = "Number of seconds to retain a message"
}

variable "dlq_kms_data_key_reuse_period" {
  type        = number
  default     = 300
  description = "Number of seconds to reuse KMS data key"
}

variable "dlq_max_msg_size" {
  type        = number
  default     = 262144 // 256 KB
  description = "Max size of the message in bytes"
}

variable "dlq_visibility_timeout" {
  type        = number
  default     = 30
  description = "Timeout for message visibility in seconds"
}

#---------------------------#

variable "vpc_config" {
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = null
}

#---------------------------#

variable "secrets_config" {
  type = list(object({
    secret_name = string
    secret_keys = list(string)
  }))
  default = []
}
