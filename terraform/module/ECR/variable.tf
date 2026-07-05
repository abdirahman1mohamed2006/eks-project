variable "ecr_repository_name" {
  type    = string
  default = "eks-assignment"
}

variable "image_tag_mutability" {
  description = "Whether image tags can be overwritten. Valid values are MUTABLE or IMMUTABLE."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Whether images are scanned after being pushed to the repository."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the ECR repository."
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}
