# ----------------------------------------------------------------------------------------------------
# --------------------------- VPC with 2 private subnets & 2 public subnets --------------------------
# ----------------------------------------------------------------------------------------------------

# ----------------------------- VPC, Main Network ACL & DHCP Options Set -----------------------------

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name"                                        = "eksctlcluster/VPC"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
  }

  tags_all = {
    "Name"                                        = "eksctl-cluster/VPC"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
  }
}

/*
# Main Network ACL
resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.vpc.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

# DHCP Options Set & Association
resource "aws_vpc_dhcp_options" "dhcp_options_set" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS",]

  tags = {
    "Cost Center" = var.cost_center
  }
}

resource "aws_vpc_dhcp_options_association" "association" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options_set.id
}

# ----------------------------------------------------------------------------------------------------
# -------------------------- Main Public Route Table & Internet Gateway ------------------------------

# Main (Public) Route Table associated with VPC.
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id

  route = [
    {
      core_network_arn           = ""
      carrier_gateway_id         = ""
      cidr_block                 = var.rt_public_route1_cidr_block
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = aws_internet_gateway.gw.id
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },
  ]

  tags = {
    Name = var.rt_public_name
  }
}

# Internet Gatewat
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.gw_name
  }
}

# ----------------------------------------------------------------------------------------------------
# ------------------------------ Private Route Table & NAT Gateway  ----------------------------------

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc.id

  route = [
    {
      core_network_arn           = ""
      carrier_gateway_id         = var.rt_private_route1_carrier_gateway_id
      cidr_block                 = var.rt_private_route1_cidr_block
      destination_prefix_list_id = var.rt_private_route1_destination_prefix_list_id
      egress_only_gateway_id     = var.rt_private_route1_egress_only_gateway_id
      gateway_id                 = var.rt_private_route1_gateway_id
      instance_id                = var.rt_private_route1_instance_id
      ipv6_cidr_block            = var.rt_private_route1_ipv6_cidr_block
      local_gateway_id           = var.rt_private_route1_local_gateway_id
      nat_gateway_id             = aws_nat_gateway.nat_gateway.id
      network_interface_id       = var.rt_private_route1_network_interface_id
      transit_gateway_id         = var.rt_private_route1_transit_gateway_id
      vpc_endpoint_id            = var.rt_private_route1_vpc_endpoint_id
      vpc_peering_connection_id  = var.rt_private_route1_vpc_peering_connection_id
    },
    {
    carrier_gateway_id         = var.rt_private_route2_carrier_gateway_id
    cidr_block                 = var.rt_private_route2_cidr_block
    destination_prefix_list_id = var.rt_private_route2_destination_prefix_list_id
    egress_only_gateway_id     = var.rt_private_route2_egress_only_gateway_id
    gateway_id                 = var.rt_private_route2_gateway_id
    instance_id                = var.rt_private_route2_instance_id
    ipv6_cidr_block            = var.rt_private_route2_ipv6_cidr_block
    local_gateway_id           = var.rt_private_route2_local_gateway_id
    nat_gateway_id             = var.rt_private_route2_nat_gateway_id
    network_interface_id       = var.rt_private_route2_network_interface_id
    transit_gateway_id         = var.rt_private_route2_transit_gateway_id
    vpc_endpoint_id            = var.rt_private_route2_vpc_endpoint_id
    vpc_peering_connection_id  = var.rt_private_route2_vpc_peering_connection_id
    }
  ]

  tags = {
    Name = var.rt_private_name
  }
}

# NAT Gateway associated with Private Route Table
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.subnet_public_1a.id
  allocation_id = aws_eip.eip.id

  tags       = {
    Name = var.nat_gateway_name
  }
  depends_on = [aws_internet_gateway.gw]
}

# Elastic IP associated with NAT Gateway
resource "aws_eip" "eip" {
  vpc = true
}
*/

# ----------------------------------------------------------------------------------------------------
# ---------------------------------------- 3 Public & 3 Private Subnets ------------------------------

resource "aws_subnet" "subnet_public_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_1a_cidr_block
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = true

  tags = {
    "Name"                                        = "eksctl-cluster/SubnetPublicEUCENTRAL1A"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/elb"                      = "1"
  }

  tags_all = {
    "Name"                                        = "eksctl-cluster/SubnetPublicEUCENTRAL1A"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/elb"                      = "1"
  }
}

resource "aws_subnet" "subnet_public_1b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_1b_cidr_block
  availability_zone       = var.availability_zone_b
  map_public_ip_on_launch = true

  tags = {
    "Name"                                        = "eksctl-cluster/SubnetPublicEUCENTRAL1B"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/elb"                      = "1"
  }

  tags_all = {
    "Name"                                        = "eksctl-cluster/SubnetPublicEUCENTRAL1B"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/elb"                      = "1"
  }
}

resource "aws_subnet" "subnet_public_1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_public_1c_cidr_block
  availability_zone       = var.availability_zone_c
  map_public_ip_on_launch = true

  tags = {
    "Name"                                        = "eksctl-cluster/SubnetPublicEUCENTRAL1C"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/elb"                      = "1"
  }

  tags_all = {
    "Name"                                        = "eksctl-cluster/SubnetPublicEUCENTRAL1C"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/elb"                      = "1"
  }
}

resource "aws_subnet" "subnet_private_1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_private_1a_cidr_block
  availability_zone = var.availability_zone_a

  tags = {
    "Name"                                        = "eksctl-cluster/SubnetPrivateEUCENTRAL1A"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/internal-elb"             = "1"
  }

  tags_all = {
    "Name"                                        = "eksctl-cluster/SubnetPrivateEUCENTRAL1A"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

resource "aws_subnet" "subnet_private_1b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_private_1b_cidr_block
  availability_zone = var.availability_zone_b

  tags = {
    "Name"                                        = "eksctl-cluster/SubnetPrivateEUCENTRAL1B"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/internal-elb"             = "1"
  }

  tags_all = {
    "Name"                                        = "eksctl-cluster/SubnetPrivateEUCENTRAL1B"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

resource "aws_subnet" "subnet_private_1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_private_1c_cidr_block
  availability_zone = var.availability_zone_c

  tags = {
    "Name"                                        = "eksctl-cluster/SubnetPrivateEUCENTRAL1C"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/internal-elb"             = "1"
  }

  tags_all = {
    "Name"                                        = "eksctl-cluster/SubnetPrivateEUCENTRAL1C"
    "alpha.eksctl.io/cluster-name"                = "default"
    "alpha.eksctl.io/eksctl-version"              = "0.95.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "default"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
