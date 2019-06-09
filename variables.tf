variable "vpc_peering_name" {
  type        = string
  description = "VPC Peering Connection name"
}

variable "requester_vpc_id" {
  type        = string
  description = "Requester VPC id"
}

variable "accepter_vpc_id" {
  type        = string
  description = "Accepter VPC id"
}

variable "accepter_account_id" {
  type        = string
  description = "Accepter VPC account id"
}

variable "accepter_vpc_region" {
  type        = string
  description = "Accepter VPC region"
}

variable "allow_remote_vpc_dns_resolution" {
  type        = bool
  description = "Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. This is not supported for inter-region VPC peering."
  default     = true
}

variable "add_route_table_entries" {
  type        = bool
  description = "Automatically add routes for the requester and accepter vpcs to route tables"
  default     = true
}

variable "requester_route_table_name_prefix" {
  type        = list(string)
  description = "List of prefixes used to find route tables in the requester vpc that will automatically have routes added. Prefixes are searched against tag:Name, wildcards can be used to select multiple route tables"
}

variable "accepter_route_table_name_prefix" {
  type        = list(string)
  description = "List of prefixes used to find route tables in the accepter vpc that will automatically have routes added. Prefixes are searched against tag:Name, wildcards can be used to select multiple route tables"
}
