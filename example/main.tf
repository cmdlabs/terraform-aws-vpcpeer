module "vpc-peer-test" {
  source = "github.com/cmdlabs/terraform-aws-vpcpeer?ref=0.1.0"
  providers = {
      aws.requester = "aws.mgmt"
      aws.accepter = "aws.test"
  }

  vpc_peering_name = "mgmt-test"
  requester_vpc_id = "vpc-02fd3gyt0fa98u7aa"
  accepter_vpc_id = "vpc-0158krte618409fbb7"
  accepter_account_id = "210322183761"
  accepter_vpc_region = "ap-southeast-2"
  requester_route_table_name_prefix = ["tf-mgmt-private*", "tf-mgmt-secure*"]
  accepter_route_table_name_prefix = ["tf-test-private*", "tf-test-secure*"]
}
