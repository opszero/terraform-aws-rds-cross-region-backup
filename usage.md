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
