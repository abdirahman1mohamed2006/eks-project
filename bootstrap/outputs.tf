output "github_actions_role_arn" {
  description = "Set this value as GitHub secret AWS_ROLE_ARN"
  value       = aws_iam_role.github_actions_terraform.arn
}

output "github_actions_role_name" {
  value = aws_iam_role.github_actions_terraform.name
}

output "github_actions_oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.github_actions.arn
}

output "github_actions_oidc_provider_url" {
  value = aws_iam_openid_connect_provider.github_actions.url
}
