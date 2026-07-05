variable "cluster_name" {
  type    = string
  default = "example"
}

variable "kubernetes_version" {
  type    = string
  default = "1.33"
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

variable "enable_irsa" {
  type    = bool
  default = true
}

variable "enable_cluster_creator_admin_permissions" {
  type    = bool
  default = true
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_1_id" {
  type = string
}

variable "private_subnet_2_id" {
  type = string
}

variable "private_subnet_3_id" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}

variable "public_subnet_2_id" {
  type = string
}

variable "public_subnet_3_id" {
  type = string
}

variable "node_group_desired_size" {
  type    = number
  default = 2
}

variable "node_group_max_size" {
  type    = number
  default = 3
}

variable "node_group_min_size" {
  type    = number
  default = 1
}

variable "node_group_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "aws_auth_roles" {
  type    = list(any)
  default = []
}

variable "aws_auth_users" {
  type    = list(any)
  default = []
}

variable "cluster_role_arn" {
  type = string
}

variable "ebs_csi_role_arn" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "node_group_role_arn" {
  type = string
}