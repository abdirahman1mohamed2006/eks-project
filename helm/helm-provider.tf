terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file used by the Kubernetes and Helm providers"
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Optional kubeconfig context to use. Leave empty to use the current context"
  type        = string
  default     = ""
}

provider "kubernetes" {
  config_path    = pathexpand(var.kubeconfig_path)
  config_context = var.kubeconfig_context != "" ? var.kubeconfig_context : null
}

provider "helm" {
  config_path    = pathexpand(var.kubeconfig_path)
  config_context = var.kubeconfig_context != "" ? var.kubeconfig_context : null
}