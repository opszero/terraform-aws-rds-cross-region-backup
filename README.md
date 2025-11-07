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
| <a name="input_account"></a> [account](#input\_account) | AWS Account ID | `any` | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | List of RDS instances | `any` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ID of KMS key | `any` | n/a | yes |
| <a name="input_source_region"></a> [source\_region](#input\_source\_region) | The AWS region where the source RDS instance exists | `any` | n/a | yes |
| <a name="input_target_region"></a> [target\_region](#input\_target\_region) | The AWS region where you want to copy RDS backups | `any` | n/a | yes |
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
# 🚀 Built by opsZero!

<a href="https://opszero.com"><img src="https://opszero.com/img/common/opsZero-Logo-Large.webp" width="300px"/></a>

[opsZero](https://opszero.com) provides software and consulting for Cloud + AI. With our decade plus of experience scaling some of the world’s most innovative companies we have developed deep expertise in Kubernetes, DevOps, FinOps, and Compliance.

Our software and consulting solutions enable organizations to:

- migrate workloads to the Cloud
- setup compliance frameworks including SOC2, HIPAA, PCI-DSS, ITAR, FedRamp, CMMC, and more.
- FinOps solutions to reduce the cost of running Cloud workloads
- Kubernetes optimized for web scale and AI workloads
- finding underutilized Cloud resources
- setting up custom AI training and delivery
- building data integrations and scrapers
- modernizing onto modern ARM based processors

We do this with a high-touch support model where you:

- Get access to us on Slack, Microsoft Teams or Email
- Get 24/7 coverage of your infrastructure
- Get an accelerated migration to Kubernetes

Please [schedule a call](https://calendly.com/opszero-llc/discovery) if you need support.

<br/><br/>

<div style="display: block">
  <img src="https://opszero.com/img/common/aws-advanced.png" alt="AWS Advanced Tier" width="150px" >
  <img src="https://opszero.com/img/common/aws-devops-competency.png" alt="AWS DevOps Competency" width="150px" >
  <img src="https://opszero.com/img/common/aws-eks.png" alt="AWS EKS Delivery" width="150px" >
  <img src="https://opszero.com/img/common/aws-public-sector.png" alt="AWS Public Sector" width="150px" >
</div>
<!-- END_TF_DOCS -->
