provider "aws" {
  version = "~> 2.12.0"
  region = "ap-southeast-2"
  alias = "test"
  assume_role {
    role_arn = "arn:aws:iam::243211151754:role/rolename"
  }
}

provider "aws" {
  version = "~> 2.12.0"
  region = "ap-southeast-2"
  alias = "mgmt"
  assume_role {
    role_arn = "arn:aws:iam::396739658860:role/rolename"
  }
}
