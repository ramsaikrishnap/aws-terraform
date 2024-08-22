provider "aws" {
  region = var.region
}
locals {
  tags = {
    owner = var.owner
    project = var.project
  }

}

resource "aws_iam_role" "eks_cluster" {
  name = "${var.eks_cluster_name}-role"
  assume_role_policy = <<POLICY
  {
"Version" : "2012-10-17"
"Statement" : [
    {
        "Effect" : "Allow",
        "Principal" : {
            "Service"  : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
    }
]
  }
  POLICY
}

resource "aws_iam_role_policy_attachment" "aws_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:polivy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster.name
}


resource "aws_eks_cluster" "my_eks_cluster" {
  name = var.eks_cluster_name
  version = var.eks_cluster_version
  role_arn = aws_iam_role.eks_cluster.arn
  vpc_config {
    security_group_ids = var.security_group_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access = var.endpoint_public_access
    subnet_ids = var.subnet_ids
  }
  tags = local.tags
  depends_on = [ aws_iam_role_policy_attachment.aws_eks_cluster_policy ]
}