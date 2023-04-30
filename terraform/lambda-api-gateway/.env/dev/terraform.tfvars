aws_region                         = "eu-west-1"
s3_bucket_name                     = "openai-api-chat-dev"
s3_object_key                      = "openai-api-chat-0.0.1-SNAPSHOT-aws.jar"
http_api_gateway_name              = "openai-api-client"
description                        = "openai-api-client"
api_gw_log_group_retention_in_days = 7
stage_variables                    = {}

lambda_functions = {
  chat = {
    runtime                = "java17"
    handler                = "org.springframework.cloud.function.adapter.aws.FunctionInvoker"
    function_name_variable = "chat"
    ephemeral_storage      = "512"
    memory_size            = "512"
  }
}