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
  source = "github.com/wenqiglantz/reusable-workflows-modules//terraform/modules/lambda-java?ref=main"

  lambda_code_path             = var.lambda_code_path
  lambda_archive_path          = var.lambda_archive_path
  resource_name_prefix         = var.resource_name_prefix
  lambda_function              = var.lambda_function
  lambda_log_retention_in_days = var.lambda_log_retention_in_days
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
