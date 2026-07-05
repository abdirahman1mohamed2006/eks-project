variable "github_repo_pattern" {
  type    = string
  default = "repo:abdirahman1mohamed2006/eks-project:*"
}

variable "route53_hosted_zone_arns" {
  type    = list(string)
  default = ["arn:aws:route53:::hostedzone/Z10354822X25ZQ06MIGTG"]
}

variable "cert_manager_role_name" {
  type    = string
  default = "cert-manager"
}

variable "cert_manager_service_account_namespace" {
  type    = string
  default = "cert-manager"
}

variable "cert_manager_service_account_name" {
  type    = string
  default = "cert-manager"
}

variable "external_dns_role_name" {
  type    = string
  default = "externaldns"
}

variable "external_dns_service_account_namespace" {
  type    = string
  default = "external-dns"
}

variable "external_dns_service_account_name" {
  type    = string
  default = "external-dns"
}

variable "oidc_provider_arn" {
  type        = string
  description = "ARN of the GitHub Actions OIDC provider"
}

variable "oidc_provider_url" {
  type        = string
  description = "URL of the GitHub Actions OIDC provider"
}

variable "eks_oidc_provider_arn" {
  type        = string
  description = "ARN of the EKS cluster OIDC provider for IRSA"
  default     = ""
}

variable "eks_oidc_provider_url" {
  type        = string
  description = "URL of the EKS cluster OIDC provider for IRSA"
  default     = ""
}

variable "ebs_csi_service_account_namespace" {
  type    = string
  default = "kube-system"
}

variable "ebs_csi_service_account_name" {
  type    = string
  default = "ebs-csi-controller-sa"
}

variable "cluster_autoscaler_service_account_namespace" {
  type    = string
  default = "kube-system"
}

variable "cluster_autoscaler_service_account_name" {
  type    = string
  default = "cluster-autoscaler"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}
