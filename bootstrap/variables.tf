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

variable "tags" {
  description = "Common tags for bootstrap resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}
