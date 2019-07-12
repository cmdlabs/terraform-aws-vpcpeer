resource "aws_vpc_peering_connection" "requester" {
  provider = "aws.requester"

  vpc_id        = var.requester_vpc_id
  peer_vpc_id   = var.accepter_vpc_id
  peer_owner_id = var.accepter_account_id
  peer_region   = var.accepter_vpc_region
  auto_accept   = false

  tags = {
    Name = var.vpc_peering_name
  }
}

resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider = "aws.accepter"

  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  auto_accept               = true

  tags = {
    Name = var.vpc_peering_name
  }
}

resource "aws_vpc_peering_connection_options" "requester" {
  #https://github.com/terraform-providers/terraform-provider-aws/issues/6730
  count = data.aws_region.current.name == var.accepter_vpc_region ? 1 : 0
  provider = "aws.requester"

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id

  requester {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  #https://github.com/terraform-providers/terraform-provider-aws/issues/6730
  count = data.aws_region.current.name == var.accepter_vpc_region ? 1 : 0
  provider = "aws.accepter"

  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id

  accepter {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }
}

resource "aws_route" "requester" {
  provider = "aws.requester"

  count = length(data.aws_route_tables.requester.ids)
  route_table_id = tolist(data.aws_route_tables.requester.ids)[count.index]
  destination_cidr_block = data.aws_vpc.accepter.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id
}

resource "aws_route" "accepter" {
  provider = "aws.accepter"

  count = length(data.aws_route_tables.accepter.ids)
  route_table_id = tolist(data.aws_route_tables.accepter.ids)[count.index]
  destination_cidr_block = data.aws_vpc.requester.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id
}
