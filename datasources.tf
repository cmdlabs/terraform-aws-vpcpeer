data "aws_route_tables" "requester" {
  provider = "aws.requester"

  vpc_id = var.requester_vpc_id

  filter {
    name   = "tag:Name"
    values = var.requester_route_table_name_prefix
  }
}

data "aws_route_tables" "accepter" {
  provider = "aws.accepter"

  vpc_id = var.accepter_vpc_id

  filter {
    name   = "tag:Name"
    values = var.accepter_route_table_name_prefix
  }
}

data "aws_vpc" "requester" {
  provider = "aws.requester"

  id = var.requester_vpc_id
}

data "aws_vpc" "accepter" {
  provider = "aws.accepter"

  id = var.accepter_vpc_id
}

data "aws_region" "current" {
  provider = "aws.requester"
}
