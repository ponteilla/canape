variable "name" {}

variable "amis" {
  type = "map"

  default = {
    "eu-west-1"    = "ami-836c56fa"
    "eu-central-1" = "ami-d33f0a38"
    "us-east-1"    = "ami-2a157b55"
    "us-west-1"    = "ami-18a2b978"
  }
}

variable "spot_price" {}

variable "vpc_id" {}

variable "subnet_ids" {
  type = "list"
}

variable "root_volume_size" {
  default = "250"
}

variable "enabled" {
  default = false
}

variable "server_key" {}
