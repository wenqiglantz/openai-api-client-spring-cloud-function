terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.65.0"
    }
  }
  required_version = "~> 1.4.0"
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

#######################################
# lambda_function
#######################################
module "lambda" {
  source   = "terraform-aws-modules/lambda/aws"

  function_name           = var.lambda_function.function_name
  runtime                 = var.lambda_function.runtime
  handler                 = var.lambda_function.handler
  create_package          = false
  snap_start              = true
  publish                 = true
  ignore_source_code_hash = true

  create_current_version_allowed_triggers = false
  #  allowed_triggers                        = {
  #    api-gateway = {
  #      service    = "apigateway"
  #      source_arn = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*/*"
  #    }
  #  }

  environment_variables = {
    SPRING_CLOUD_FUNCTION_DEFINITION = var.lambda_function.function_name_variable
  }
  ephemeral_storage_size = var.lambda_function.ephemeral_storage
  memory_size            = var.lambda_function.memory_size
  package_type           = "Zip"
  timeout                = "15"
}

#######################################
# HTTP API gateway
#######################################
module "apigatewayv2" {
  source     = "github.com/wenqiglantz/reusable-workflows-modules//terraform/modules/apigatewayv2?ref=main"
  aws_region = var.aws_region

  open_api_spec = templatefile("${path.root}/openai-client-openapi.json", {
    aws_region     = var.aws_region,
    aws_account_id = data.aws_caller_identity.current.account_id
  })
  http_api_gateway_name              = var.http_api_gateway_name
  description                        = var.description
  api_gateway_stage_name             = var.api_gateway_stage_name
  api_gw_log_group_retention_in_days = var.api_gw_log_group_retention_in_days
  stage_variables                    = var.stage_variables
  lambda_function                    = var.lambda_function.function_name
}
