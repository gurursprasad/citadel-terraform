# -----------------------------------------------------------------------------
# Subnet resources for VPC
# -----------------------------------------------------------------------------
#
# - Ensure the cluster name in the tags matches the EKS cluster configuration (e.g., "dev-demo").
# - var.private_subnets: List of CIDR blocks for private subnets (from main.tf)
# - var.public_subnets: List of CIDR blocks for public subnets (from main.tf)
# - var.azs: List of availability zones (used for both subnet types)
# - Tags are merged with environment common tags using the merge() function.
#
# - We use the 'count' meta-argument to create multiple subnets dynamically based on the number of subnets needed.
# - 'length(var.private_subnets)' and 'length(var.public_subnets)' determine how many subnets to create.
# - 'count.index' is used to access the correct CIDR block and availability zone for each subnet in the list.
# -----------------------------------------------------------------------------

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      Name                               = "${var.env}-private-${var.azs[count.index]}"
      "kubernetes.io/role/internal-elb"  = "1"
      "kubernetes.io/cluster/${var.env}" = "owned" # Used by Karpenter & Cluster Autoscaler
    },
    # var.private_subnet_tags
  )
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name                               = "${var.env}-public-${var.azs[count.index]}"
      "kubernetes.io/role/elb"           = "1"
      "kubernetes.io/cluster/${var.env}" = "owned" # Used by Karpenter & Cluster Autoscaler
    },
    # var.public_subnet_tags
  )
}
