output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_cluster_role_name" {
  value = aws_iam_role.eks_cluster_role.name
}

output "node_group_role_arn" {
  value = aws_iam_role.node_group_role.arn
}

output "node_group_role_name" {
  value = aws_iam_role.node_group_role.name
}

output "cert_manager_role_arn" {
  value = aws_iam_role.cert_manager_role.arn
}

output "cert_manager_role_name" {
  value = aws_iam_role.cert_manager_role.name
}

output "external_dns_role_arn" {
  value = aws_iam_role.external_dns_role.arn
}

output "external_dns_role_name" {
  value = aws_iam_role.external_dns_role.name
}

output "ebs_csi_role_arn" {
  value = aws_iam_role.ebs_csi_role.arn
}

output "ebs_csi_role_name" {
  value = aws_iam_role.ebs_csi_role.name
}

output "cluster_autoscaler_role_arn" {
  value = aws_iam_role.cluster_autoscaler_role.arn
}

output "cluster_autoscaler_role_name" {
  value = aws_iam_role.cluster_autoscaler_role.name
}
