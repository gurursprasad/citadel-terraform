# IAM Role for worker Nodes
resource "aws_iam_role" "this" {
    name               = "${var.env}-${var.eks_name}-node-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Effect    = "Allow"
            Principal = {
            Service = "ec2.amazonaws.com"
            }
            Action   = "sts:AssumeRole"
        }
        ]
    })
}

resource "aws_iam_policy_attachment" "amazon_eks_worker_node_policy" {
    name       = "${var.env}-${var.eks_name}-worker-node-policy-attachment"
    roles      = [aws_iam_role.this.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_policy_attachment" "amazon_eks_cni_policy" {
    name       = "${var.env}-${var.eks_name}-cni-policy-attachment"
    roles      = [aws_iam_role.this.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_policy_attachment" "amazon_ec2_container_registry_read_only" {
    name       = "${var.env}-${var.eks_name}-ec2-container-registry-read-only-attachment"
    roles      = [aws_iam_role.this.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# EKS Node Group Creation
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "general"
  node_role_arn   = aws_iam_role.this.arn
  subnet_ids      = var.private_subnets

  depends_on = [
    aws_iam_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_policy_attachment.amazon_eks_cni_policy,
    aws_iam_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  capacity_type = "ON_DEMAND"
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}