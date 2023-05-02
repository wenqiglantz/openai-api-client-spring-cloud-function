<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.65 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apigatewayv2"></a> [apigatewayv2](#module\_apigatewayv2) | github.com/wenqiglantz/reusable-workflows-modules//terraform/modules/apigatewayv2 | main |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | github.com/wenqiglantz/reusable-workflows-modules//terraform/modules/lambda_java | main |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_gateway_stage_name"></a> [api\_gateway\_stage\_name](#input\_api\_gateway\_stage\_name) | HTTP API Gateway stage name | `string` | `""` | no |
| <a name="input_api_gw_log_group_retention_in_days"></a> [api\_gw\_log\_group\_retention\_in\_days](#input\_api\_gw\_log\_group\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, etc. | `number` | `7` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | HTTP API Gateway description | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `string` | `"dev"` | no |
| <a name="input_http_api_gateway_name"></a> [http\_api\_gateway\_name](#input\_http\_api\_gateway\_name) | Name of the HTTP API Gateway | `string` | `""` | no |
| <a name="input_lambda_archive_path"></a> [lambda\_archive\_path](#input\_lambda\_archive\_path) | Lambda code archive path | `string` | `""` | no |
| <a name="input_lambda_code_file"></a> [lambda\_code\_file](#input\_lambda\_code\_file) | Lambda code jar file | `string` | `""` | no |
| <a name="input_lambda_function"></a> [lambda\_function](#input\_lambda\_function) | Lambda function details | `map(any)` | <pre>{<br>  "ephemeral_storage": "512",<br>  "function_name": "chat",<br>  "function_name_variable": "chat",<br>  "handler": "org.springframework.cloud.function.adapter.aws.FunctionInvoker",<br>  "memory_size": "128",<br>  "runtime": "java17",<br>  "timeout": "15"<br>}</pre> | no |
| <a name="input_lambda_log_retention_in_days"></a> [lambda\_log\_retention\_in\_days](#input\_lambda\_log\_retention\_in\_days) | Log retention in days | `number` | `7` | no |
| <a name="input_open_api_spec"></a> [open\_api\_spec](#input\_open\_api\_spec) | OpenAPI Spec | `any` | `""` | no |
| <a name="input_resource_name_prefix"></a> [resource\_name\_prefix](#input\_resource\_name\_prefix) | Resource name prefix, used in role name | `string` | `""` | no |
| <a name="input_stage_variables"></a> [stage\_variables](#input\_stage\_variables) | API Gateway stage variables | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_url"></a> [api\_url](#output\_api\_url) | n/a |
<!-- END_TF_DOCS -->