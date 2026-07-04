

module "vpc" {
  source = "./terraform/module/VPC"

  aws_region = var.aws_region
}

data "terraform_remote_state" "bootstrap" {
  backend = "local"

  config = {
    path = "${path.root}/bootstrap/terraform.tfstate"
  }
}

module "irsa" {
  source = "./terraform/module/IAM"

  github_repo_pattern       = var.github_repo_pattern
  route53_hosted_zone_arns  = var.route53_hosted_zone_arns
  oidc_provider_arn         = data.terraform_remote_state.bootstrap.outputs.github_actions_oidc_provider_arn
  oidc_provider_url         = data.terraform_remote_state.bootstrap.outputs.github_actions_oidc_provider_url
  tags                      = var.tags
}

module "eks" {
  source = "./terraform/module/EKS"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id = module.vpc.vpc_id

  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
  private_subnet_3_id = module.vpc.private_subnet_3_id

  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  public_subnet_3_id = module.vpc.public_subnet_3_id

  cluster_role_arn = module.irsa.cluster_role_arn
  ebs_csi_role_arn = module.irsa.ebs_csi_role_arn
  node_group_role_arn = module.irsa.node_group_role_arn

  tags = var.tags
}

module "ecr" {
  source = "./terraform/module/ECR"

  ecr_repository_name = var.ecr_repository_name
  tags                = var.tags
}
