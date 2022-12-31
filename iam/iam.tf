resource "aws_iam_role" "cluster_role" {
  name        = "eksctl-default-cluster-ServiceRole"
  description = ""

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags     = {
    "Name"                                        = "eksctl-default-cluster/ServiceRole"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
  }
  tags_all = {
    "Name"                                        = "eksctl-default-cluster/ServiceRole"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
  }
}

resource "aws_iam_role" "nodegroup_role" {
  name        = "AmazonEKSNodeRole"
  description = "Allows EC2 instances to call AWS services on your behalf."

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role" "autoscalerrole" {
  name        = "AmazonEKSClusterAutoscalerRole"
  description = "Amazon EKS - Cluster autoscaler role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRoleWithWebIdentity"
        Effect    = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${var.account_id}:oidc-provider/oidc.eks.eu-central-1.amazonaws.com/id/${var.principal}"
        }
        Condition = {
          StringEquals = {
            "oidc.eks.eu-central-1.amazonaws.com/id/${var.oidc}:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
          }
        }
      },
    ]
  })
}
