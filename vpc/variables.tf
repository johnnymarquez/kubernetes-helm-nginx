variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = ""
}

variable "subnet_private_1a_name" {
  default = ""
}

variable "subnet_private_1b_name" {
  default = ""
}

variable "subnet_private_1c_name" {
  default = ""
}

variable "subnet_public_1a_name" {
  default = ""
}

variable "subnet_public_1b_name" {
  default = ""
}

variable "subnet_public_1c_name" {
  default = ""
}

variable "cost_center" {
  default = "Tigo-Web-All"
}

variable "subnet_private_1a_cidr_block" {
  default = "10.0.1.0/24"
}

variable "subnet_private_1b_cidr_block" {
  default = "10.0.1.0/24"
}

variable "subnet_private_1c_cidr_block" {
  default = "10.0.1.0/24"
}

variable "subnet_public_1a_cidr_block" {
  default = "10.0.1.0/24"
}

variable "subnet_public_1b_cidr_block" {
  default = "10.0.1.0/24"
}

variable "subnet_public_1c_cidr_block" {
  default = "10.0.1.0/24"
}

variable "gw_name" {
  default = ""
}

variable "nat_gateway_name" {
  default = ""
}

variable "rt_public_name" {
  default = ""
}

variable "rt_public_route1_cidr_block" {
  default = "10.0.1.0/24"
}

variable "rt_private_name" {
  default = ""
}

variable "rt_private_route1_carrier_gateway_id" {
  default = ""
}

variable "rt_private_route1_cidr_block" {
  default = ""
}

variable "rt_private_route1_destination_prefix_list_id" {
  default = ""
}

variable "rt_private_route1_egress_only_gateway_id" {
  default = ""
}

variable "rt_private_route1_gateway_id" {
  default = ""
}

variable "rt_private_route1_instance_id" {
  default = ""
}

variable "rt_private_route1_ipv6_cidr_block" {
  default = ""
}

variable "rt_private_route1_local_gateway_id" {
  default = ""
}

variable "rt_private_route1_nat_gateway_id" {
  default = ""
}

variable "rt_private_route1_network_interface_id" {
  default = ""
}

variable "rt_private_route1_transit_gateway_id" {
  default = ""
}

variable "rt_private_route1_vpc_endpoint_id" {
  default = ""
}

variable "rt_private_route1_vpc_peering_connection_id" {
  default = ""
}

variable "rt_private_route2_carrier_gateway_id" {
  default = ""
}

variable "rt_private_route2_cidr_block" {
  default = ""
}

variable "rt_private_route2_destination_prefix_list_id" {
  default = ""
}

variable "rt_private_route2_egress_only_gateway_id" {
  default = ""
}

variable "rt_private_route2_gateway_id" {
  default = ""
}

variable "rt_private_route2_instance_id" {
  default = ""
}

variable "rt_private_route2_ipv6_cidr_block" {
  default = ""
}

variable "rt_private_route2_local_gateway_id" {
  default = ""
}

variable "rt_private_route2_nat_gateway_id" {
  default = ""
}

variable "rt_private_route2_network_interface_id" {
  default = ""
}

variable "rt_private_route2_transit_gateway_id" {
  default = ""
}

variable "rt_private_route2_vpc_endpoint_id" {
  default = ""
}

variable "rt_private_route2_vpc_peering_connection_id" {
  default = ""
}

variable "availability_zone_a" {
  default = "us-east-1a"
}

variable "availability_zone_b" {
  default = "us-east-1b"
}

variable "availability_zone_c" {
  default = "us-east-1b"
}