data "aws_region" "current" {}

provider "aws" {
  region = "${data.aws_region.current.id}"
}

provider "aws" {
  alias = "us-east"
  region = "us-east-1"
}
