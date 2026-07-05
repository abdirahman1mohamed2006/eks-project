

module "vpc" {
  source = "./module/VPC"

  aws_region = var.aws_region
}

data "terraform_remote_state" "bootstrap" {
  backend = "s3"

  config = {
    bucket = var.bootstrap_state_bucket
    key    = var.bootstrap_state_key
    region = var.aws_region
  }
}

module "irsa" {
  source = "./module/IAM"

  github_repo_pattern                          = var.github_repo_pattern
  route53_hosted_zone_arns                     = var.route53_hosted_zone_arns
  cert_manager_role_name                       = var.cert_manager_role_name
  cert_manager_service_account_namespace       = var.cert_manager_service_account_namespace
  cert_manager_service_account_name            = var.cert_manager_service_account_name
  external_dns_role_name                       = var.external_dns_role_name
  external_dns_service_account_namespace       = var.external_dns_service_account_namespace
  external_dns_service_account_name            = var.external_dns_service_account_name
  ebs_csi_service_account_namespace            = var.ebs_csi_service_account_namespace
  ebs_csi_service_account_name                 = var.ebs_csi_service_account_name
  cluster_autoscaler_service_account_namespace = var.cluster_autoscaler_service_account_namespace
  cluster_autoscaler_service_account_name      = var.cluster_autoscaler_service_account_name
  oidc_provider_arn                            = data.terraform_remote_state.bootstrap.outputs.github_actions_oidc_provider_arn
  oidc_provider_url                            = data.terraform_remote_state.bootstrap.outputs.github_actions_oidc_provider_url
  eks_oidc_provider_arn                        = module.eks.oidc_provider_arn
  eks_oidc_provider_url                        = module.eks.oidc_provider_url
  tags                                         = var.tags

  depends_on = [module.eks]
}

module "eks" {
  source = "./module/EKS"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id = module.vpc.vpc_id

  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
  private_subnet_3_id = module.vpc.private_subnet_3_id

  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id
  public_subnet_3_id = module.vpc.public_subnet_3_id

  cluster_role_arn    = module.irsa.cluster_role_arn
  ebs_csi_role_arn    = module.irsa.ebs_csi_role_arn
  node_group_role_arn = module.irsa.node_group_role_arn

  tags = var.tags
}

module "ecr" {
  source = "./module/ECR"

  ecr_repository_name = var.ecr_repository_name
  tags                = var.tags
}
