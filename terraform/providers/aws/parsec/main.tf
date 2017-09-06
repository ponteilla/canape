provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "local" {}
}

data "aws_availability_zones" "azs" {}

module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc?ref=v1.0.8"

  name               = "parsec"
  cidr               = "10.0.0.0/16"
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_dns_support = "true"

  azs = ["${data.aws_availability_zones.azs.names[0]}", "${data.aws_availability_zones.azs.names[1]}"]
}

module "parsec" {
  source = "../../../modules/aws/parsec"

  name             = "${var.name}"
  vpc_id           = "${module.vpc.vpc_id}"
  subnet_ids       = "${module.vpc.public_subnets}"
  root_volume_size = "${var.volume_size}"
  spot_price       = "${var.spot_price}"
  enabled          = "${var.enabled}"

  server_key = "${var.server_key}"
}
