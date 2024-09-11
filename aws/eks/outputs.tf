output "cluster_name" {
  value = aws_eks_cluster.my_eks_cluster.name
}
output "cluster_endpoint" {
  value= aws_eks_cluster.my_eks_cluster.endpoint
}
output "oidc_url" {
  value = aws_eks_cluster.my_eks_cluster.identity[0].oidc[0].issuer
}
output "node_security_group_id" {
  value = aws_security_group.eks_nodes.id
}
output "cluster_security_group_id" {
  value = aws_security_group.eks_cluster.id
}