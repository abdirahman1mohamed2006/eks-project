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

variable "cert_manager_role_name" {
  description = "IAM role name for cert-manager IRSA"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_service_account_namespace" {
  description = "Kubernetes namespace for cert-manager service account"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_service_account_name" {
  description = "Kubernetes service account name for cert-manager"
  type        = string
  default     = "cert-manager"
}

variable "external_dns_role_name" {
  description = "IAM role name for external-dns IRSA"
  type        = string
  default     = "externaldns"
}

variable "external_dns_service_account_namespace" {
  description = "Kubernetes namespace for external-dns service account"
  type        = string
  default     = "external-dns"
}

variable "external_dns_service_account_name" {
  description = "Kubernetes service account name for external-dns"
  type        = string
  default     = "external-dns"
}

variable "ebs_csi_service_account_namespace" {
  description = "Kubernetes namespace for EBS CSI service account"
  type        = string
  default     = "kube-system"
}

variable "ebs_csi_service_account_name" {
  description = "Kubernetes service account name for EBS CSI"
  type        = string
  default     = "ebs-csi-controller-sa"
}

variable "cluster_autoscaler_service_account_namespace" {
  description = "Kubernetes namespace for cluster-autoscaler service account"
  type        = string
  default     = "kube-system"
}

variable "cluster_autoscaler_service_account_name" {
  description = "Kubernetes service account name for cluster-autoscaler"
  type        = string
  default     = "cluster-autoscaler"
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

variable "bootstrap_state_bucket" {
  description = "S3 bucket that stores bootstrap Terraform state"
  type        = string
  default     = "eks-project-bootstrap-tfstate-abdirahman-2006"
}

variable "bootstrap_state_key" {
  description = "S3 object key for bootstrap Terraform state"
  type        = string
  default     = "bootstrap/terraform.tfstate"
}

variable "tags" {
  description = "Common tags for Terraform-managed resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}
