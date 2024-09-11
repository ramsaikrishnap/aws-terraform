# Local Variable for tags
locals {
  tags = {
    owner = var.owner
    project = var.project
    environment = var.environment
  }

}
# AWS IAM Role
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

# EKS Cluster Security Group and its relavant secruity group rules
# Note : Additional security group rules can be added as per your custom requirements
resource "aws_security_group" "eks_cluster"{
  name = "${var.eks_cluster_name}-cluster-sg"
  description = "Security group for cluster commmunication with worker nodes"
  vpc_id = var.vpc_id
  tags = {
    name = "${var.eks_cluster_name}-cluster-sg"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
    environment = var.environment
    project = var.project
  }
}
resource "aws_security_group_rule" "cluster_inbound"{
  description = "Security group rule for allowing worker nodes to communicate with cluster API server"
  from_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port = 443
  type = "ingress"
  
}

resource "aws_security_group_rule" "cluster_outbound"{
  description = "Security group rule for allowing cluster API server to communicate with the worker nodes"
  from_port = 1024
  protocol = "tcp"
  security_group_id = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port = 65535
  type = "engress"
  
}
# EKS Node Security Group and its relavant secruity group rules
# Note : Additional security group rules can be added as per your custom requirements
resource "aws_security_group" "eks_nodes"{
  name = "${var.eks_cluster_name}-nodes-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id = var.vpc_id
  egress = {
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "${var.eks_cluster_name}-nodes-sg"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "owned"
    environment = var.environment
    project = var.project
  }
}

resource "aws_security_group_rule" "nodes"{
  description = "Security group rule for allowing nodes to communicate with each other"
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port = 65535
  type = "ingress"
  
}

resource "aws_security_group_rule" "nodes_inbound"{
  description = "Security group rule for allowing worker kubelets and pods to recive communication from cluster control plane"
  from_port = 1024
  protocol = "tcp"
  security_group_id = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_cluster.id
  to_port = 65535
  type = "ingress"
  
}
# AWS EKS Cluster Policy attachment
resource "aws_iam_role_policy_attachment" "aws_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster.name
}

# AWS EKS cluster Creation
resource "aws_eks_cluster" "my_eks_cluster" {
  name = var.eks_cluster_name
  version = var.eks_cluster_version
  role_arn = aws_iam_role.eks_cluster.arn
  vpc_config {
    security_group_ids = [aws_security_group.eks_cluster.id]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access = var.endpoint_public_access
    subnet_ids = var.subnet_ids
  }
  tags = local.tags
  depends_on = [ aws_iam_role_policy_attachment.aws_eks_cluster_policy ]
}