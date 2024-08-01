################################################################################
# EKS
################################################################################

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks.arn
  version  = var.cluster_version
  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
  }
  tags = merge({ "Name" = var.cluster_name }, var.tags)
}


resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.subnet_ids
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  version = var.cluster_version
  tags = merge({ "Name" = var.node_group_name }, var.tags)
}