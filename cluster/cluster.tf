resource "aws_eks_cluster" "cluster" {
  role_arn                  = "arn:aws:iam::4${var.account_id}:role/eksctl-default-clus-ServiceRole"
  enabled_cluster_log_types = []
  name                      = "default"
  version                   = "1.22"
  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = "10.100.0.0/16"
  }
  timeouts {}
  vpc_config {
    public_access_cidrs = [
      "0.0.0.0/0",
    ]
    security_group_ids  = [

    ]
    subnet_ids          = [

    ]
  }

  tags     = {
    "Name"                                        = "eksctl-default-cluster/ControlPlane"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
  }
  tags_all = {
    "Name"                                        = "eksctl-default-cluster/ControlPlane"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"

  }
}

resource "aws_eks_node_group" "nodegroup" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "nodegroup"
  node_role_arn   = "arn:aws:iam::${account_id}:role/AmazonEKSNodeRole"
  subnet_ids      = [

  ]

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = "20"
  instance_types = ["t3.medium"]

  tags     = {
    "k8s.io/cluster-autoscaler/default" = "owned"
    "k8s.io/cluster-autoscaler/enabled" = "true"
  }
  tags_all = {
    "k8s.io/cluster-autoscaler/default" = "owned"
    "k8s.io/cluster-autoscaler/enabled" = "true"
  }
}
