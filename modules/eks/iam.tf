################################################################################
# ROLE FOR EKS CLUSTER
################################################################################


resource "aws_iam_role" "eks" {
  name = "${var.cluster_name}-eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })

  tags = {
    Name = "${var.cluster_name}-eks-role"
  }
}


################################################################################
# ROLE FOR EKS CLUSTER NODE
################################################################################
resource "aws_iam_role" "node" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })

  tags = {
    Name = "${var.cluster_name}-node-role"
  }
}

################################################################################
# POLICY_ATTACHMENT CLUSTER
################################################################################

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks.name
}

################################################################################
# POLICY_ATTACHMENT NODE
################################################################################

resource "aws_iam_role_policy_attachment" "node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}
resource "aws_iam_role_policy_attachment" "node_ec2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}
resource "aws_iam_role_policy_attachment" "node_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_instance_profile" "node" {
  name = "${var.cluster_name}-node-instance-profile"
  role = aws_iam_role.node.name
}