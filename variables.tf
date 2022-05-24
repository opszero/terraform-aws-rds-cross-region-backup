variable "source_region" {
  description = "The AWS region where the source RDS instance exists"
}

variable "target_region" {
  description = "The AWS region where you want to copy RDS backups"
}

variable "instances" {
  description = "List of RDS instances"
}

variable "account" {
  description = "AWS Account ID"
}

variable "kms_key_id" {
  description = "The ID of KMS key"
}
