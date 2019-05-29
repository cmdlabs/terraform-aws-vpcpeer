resource "aws_vpc_peering_connection" "requester" {
  provider = "aws.requester"

  vpc_id        = var.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = var.peer_account_id
  peer_region   = var.peer_region
  auto_accept   = false
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider = "aws.accepter"

  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  auto_accept               = true
}

resource "aws_vpc_peering_connection_options" "requester" {
  provider = "aws.requester"

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id

  requester {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  provider = "aws.accepter"

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id

  accepter {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }
}
