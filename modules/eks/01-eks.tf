# IAM Roles for EKS Control Plane
# EKS needs permissions to interact with other AWS services. 
# We create an IAM role for this purpose and define trust policy. This is usially done in the Principal property in the iam role
# IAM role is assumable by anyone who needs it and has the right permissions.
# We then need to attach permissions to this role. We'll use AmazonEKSClusterPolicy.

# IAM Roles for Worker Nodes
# AmazonEKSWorkerNodePolicy provides core ec2 permissions to the worker nodes.
# AmazonEKS_CNI_Policy provides permissions for the CNI plugin to manage networking.
# AmazonEC2ContainerRegistryReadOnly allows worker nodes to pull images from ECR.

# IAM Role for EKS Cluster
# This role is used by the EKS cluster to manage resources within the cluster.
resource "aws_iam_role" "this" {
    name = "${var.env}-${var.eks_name}-cluster-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Effect = "Allow"
            Principal = {
            Service = "eks.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "eks" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.this.name
}

# Cluster Creation
resource "aws_eks_cluster" "this" {
  name = "${var.env}-${var.eks_name}-cluster"
  depends_on = [aws_iam_role_policy_attachment.eks]

  role_arn = aws_iam_role.this.arn
  version  = "1.31"

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = var.private_subnets
  }

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }
}