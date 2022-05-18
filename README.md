<!-- BEGIN_TF_DOCS -->
# Releasing

 - Update .chalice/config.json
 - Add a stage with the appropriate environment variables
 - `make deploy-AWSPROFILE`
# rds-cross-region-backup

# Deployment via Terraform

```sh
terraform init
terraform plan
terraform apply -auto-approve
```
# Teardown

```sh
terraform destroy -auto-approve
```
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | `any` | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | n/a | `any` | n/a | yes |
| <a name="input_source_region"></a> [source\_region](#input\_source\_region) | n/a | `any` | n/a | yes |
| <a name="input_target_region"></a> [target\_region](#input\_target\_region) | n/a | `any` | n/a | yes |
## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.every_five_days](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.rds_cross_region_backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.iam_policy_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.rds_cross_region_backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_cloudwatch_to_call_rds_cross_region_backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
## Outputs

No outputs.
<!-- END_TF_DOCS -->