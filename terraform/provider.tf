terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "eks-project-bootstrap-tfstate-abdirahman-2006"
    key          = "terraform/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}