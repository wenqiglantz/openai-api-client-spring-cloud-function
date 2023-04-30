output "lambda_name" {
  value       = module.lambda.lambda_name
  description = "Lambda function name"
}

output "lambda_arn" {
  value       = module.lambda.lambda_arn
  description = "Lambda function ARN name"
}

output "api_url" {
  value = module.apigatewayv2.base_url
}