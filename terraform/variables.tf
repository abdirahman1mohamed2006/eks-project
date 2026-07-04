variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-assignment"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.33"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "eks-assignment"
}

variable "github_repo_pattern" {
  description = "GitHub OIDC subject pattern for GitHub Actions IAM roles"
  type        = string
  default     = "repo:abdirahman1mohamed2006/eks-project:*"
}

variable "route53_hosted_zone_arns" {
  description = "Route 53 hosted zone ARNs for DNS-related IAM policies"
  type        = list(string)
  default     = ["arn:aws:route53:::hostedzone/Z10354822X25ZQ06MIGTG"]
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA roles"
  type        = string
  default     = ""
}

variable "oidc_provider_url" {
  description = "OIDC provider URL for IRSA roles"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags for Terraform-managed resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}
