provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "local" {}
}

data "aws_availability_zones" "azs" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name           = "parsec-${substr(var.server_key, 0, 4)}"
  cidr           = "10.0.0.0/16"
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  azs = ["${data.aws_availability_zones.azs.names[0]}", "${data.aws_availability_zones.azs.names[1]}"]
}

module "parsec" {
  source = "../../../modules/aws/parsec"

  name             = "${substr(var.server_key, 0, 4)}"
  vpc_id           = "${module.vpc.vpc_id}"
  subnet_ids       = "${module.vpc.public_subnets}"
  root_volume_size = "${var.volume_size}"
  spot_price       = "${var.spot_price}"
  enabled          = "${var.enabled}"

  server_key = "${var.server_key}"
}
