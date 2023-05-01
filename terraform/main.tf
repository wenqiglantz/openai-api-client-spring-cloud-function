terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.65"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # default tags per https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block
  default_tags {
    tags = {
      env       = var.environment
      ManagedBy = "Terraform"
    }
  }
}

#data "aws_caller_identity" "current" {}

#######################################
# lambda_function
#######################################
module "lambda" {
  source = "github.com/wenqiglantz/reusable-workflows-modules//terraform/modules/lambda_java?ref=main"

  lambda_code_file             = var.lambda_code_file
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
    qualified_invoke_arn = module.lambda.qualified_invoke_arn
  })
  http_api_gateway_name              = var.http_api_gateway_name
  description                        = var.description
  api_gateway_stage_name             = var.api_gateway_stage_name
  api_gw_log_group_retention_in_days = var.api_gw_log_group_retention_in_days
  stage_variables                    = var.stage_variables
  lambda_function                    = var.lambda_function.function_name
}
