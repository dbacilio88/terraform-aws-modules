# outputs.tf

output "cluster_id" {
  description = "The ID of the EKS cluster."
  value       = aws_eks_cluster.this.id
}

output "cluster_endpoint" {
  description = "The endpoint URL of the EKS cluster."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
  description = "The version of the EKS cluster."
  value       = aws_eks_cluster.this.version
}

output "node_group_id" {
  description = "The ID of the EKS node group."
  value       = aws_eks_node_group.this.id
}
