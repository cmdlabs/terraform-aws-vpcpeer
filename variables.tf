variable "vpc_id" {
  type        = string
  description = "Source VPC Id"
}

variable "peer_vpc_id" {
  type        = string
  description = "Peer VPC Id"
}

variable "peer_account_id" {
  type        = string
  description = "Peer VPC Account Id"
}

variable "peer_region" {
  type        = string
  description = "Peer VPC region"
}

variable "allow_remote_vpc_dns_resolution" {
  type        = bool
  description = "Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. This is not supported for inter-region VPC peering."
  default     = true
}




