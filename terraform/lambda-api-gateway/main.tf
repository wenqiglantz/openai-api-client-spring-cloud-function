terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.45.0"
    }
  }
  required_version = "~> 1.4.0"
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

#######################################
# S3 module
#######################################
module "s3" {
  source         = "github.com/wenqiglantz/reusable-workflows-modules//terraform/modules/s3?ref=main"
  aws_region     = var.aws_region
  s3_bucket_name = var.s3_bucket_name
  s3_object_key  = var.s3_object_key
}

#######################################
# lambda_function
#######################################
module "lambda" {
  source   = "terraform-aws-modules/lambda/aws"
  for_each = var.lambda_functions

  function_name       = each.key
  runtime             = each.value.runtime
  handler             = each.value.handler
  create_package      = false
  snap_start          = true
  publish             = true
  s3_existing_package = {
    bucket = var.s3_bucket_name
    key    = var.s3_object_key
  }

  create_current_version_allowed_triggers = false
#  allowed_triggers                        = {
#    api-gateway = {
#      service    = "apigateway"
#      source_arn = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*/*"
#    }
#  }

  environment_variables = {
    SPRING_CLOUD_FUNCTION_DEFINITION = each.value.function_name_variable
  }
  ephemeral_storage_size = each.value.ephemeral_storage
  memory_size            = each.value.memory_size
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
  lambda_function                    = element(keys(module.lambda.lambda_name), 0)
}
