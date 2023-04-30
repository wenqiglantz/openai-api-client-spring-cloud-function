variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store the Lambda function code"
  default     = ""
}

variable "s3_object_key" {
  type        = string
  description = "The S3 object key, the zip file name"
  default     = ""
}

variable "open_api_spec" {
  type        = any
  description = "OpenAPI Spec"
}

variable "lambda_functions" {
  description = "Map of Lambda function details"
  type        = map(any)
  default     = {
    function_name = {
      runtime                = "java17"
      handler                = "org.springframework.cloud.function.adapter.aws.FunctionInvoker"
      ephemeral_storage      = "512"
      memory_size            = "128"
      function_name_variable = "chat"
    }
  }
}

variable "http_api_gateway_name" {
  description = "Name of the HTTP API Gateway"
  type        = string
  default     = ""
}

variable "description" {
  description = "HTTP API Gateway description"
  type        = string
  default     = ""
}

variable "api_gw_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, etc."
  type        = number
  default     = 7
}

variable "api_gateway_stage_name" {
  description = "HTTP API Gateway stage name"
  type        = string
  default     = ""
}

variable "stage_variables" {
  description = "API Gateway stage variables"
  type        = map(any)
  default     = {}
}
