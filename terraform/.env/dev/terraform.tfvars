aws_region                         = "eu-west-1"
http_api_gateway_name              = "openai-api-client"
api_gateway_stage_name             = "dev"
description                        = "openai-api-client"
api_gw_log_group_retention_in_days = 7
stage_variables                    = {}

lambda_code_file             = "../target/openai-api-chat-0.0.1-SNAPSHOT-aws.jar"
lambda_archive_path          = "../target/openai-api-chat-0.0.1-SNAPSHOT-aws.zip"
resource_name_prefix         = "chat"
lambda_log_retention_in_days = 7
lambda_function              = {
  function_name          = "chat"
  runtime                = "java11"
  handler                = "org.springframework.cloud.function.adapter.aws.FunctionInvoker"
  function_name_variable = "chat"
  ephemeral_storage      = "512"
  memory_size            = "512"
}
