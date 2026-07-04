variable "aws_region" {
  description = "AWS region for bootstrap resources"
  type        = string
  default     = "eu-west-1"
}

variable "github_repo_pattern" {
  description = "GitHub OIDC subject pattern, e.g. repo:owner/repo:*"
  type        = string
  default     = "repo:abdirahman1mohamed2006/eks-project:*"
}

variable "github_actions_role_name" {
  description = "IAM role name assumed by GitHub Actions"
  type        = string
  default     = "github-actions-terraform-role"
}

variable "tf_state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
  default     = "eks-project-bootstrap-tfstate-abdirahman-2006"
}

variable "tf_state_key" {
  description = "Object key for bootstrap terraform state"
  type        = string
  default     = "bootstrap/terraform.tfstate"
}

variable "tags" {
  description = "Common tags for bootstrap resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}
