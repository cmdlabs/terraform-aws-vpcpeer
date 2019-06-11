# terraform-aws-vpcpeer
## Summary
This module deploys VPC peering and adds the required routes to the selected route tables.

## Provider Mapping
Multiple providers are utilised to provision both sides of the peer in a single stack. One side is referred to as the requester, and the other side is reffered to as the accepter. You need to map your providers like below;

```
# provider.tf
provider "aws" {
  alias = "mgmt"
}

provider "aws" {
  alias = "test"
}

# main.tf
module "vpc-peer-test" {
    providers = {
        aws.requester = "aws.mgmt"
        aws.accepter = "aws.test"
    }
}
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_peering_name | VPC Peering Connection name | string | n/a | yes |
| requester_vpc_id | Requester VPC id | string | n/a | yes |
| accepter_vpc_id | Accepter VPC id | string | n/a | yes |
| accepter_account_id | Accepter VPC account id | string | n/a | yes |
| accepter_vpc_region | Accepter VPC region | string | n/a | yes |
| allow_remote_vpc_dns_resolution | Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. This is not supported for inter-region VPC peering | bool | `true` | no |
| add_route_table_entries | Automatically add routes for the requester and accepter vpcs to route tables bool | `true` | no |
| requester_route_table_name_prefix | List of prefixes used to find route tables in the requester vpc that will automatically have routes added. Prefixes are searched against tag:Name, wildcards can be used to select multiple route tables | list(string) | n/a | yes |
| accepter_route_table_name_prefix | List of prefixes used to find route tables in the accepter vpc that will automatically have routes added. Prefixes are searched against tag:Name, wildcards can be used to select multiple route tables | list(string) | n/a | yes |


## Outputs
| Name | Description |
|------|-------------|
| vpc_peering_connection_id | VPC Peering PCX ID
