variable "name" {}

variable "amis" {
  type = "map"

  default = {
    "eu-west-1"    = "ami-1e695067"
    "eu-central-1" = "ami-060823ed"
    "us-east-1"    = "ami-4efe9931"
    "us-west-1"    = "ami-e06d7680"
  }
}

variable "spot_price" {}

variable "vpc_id" {}

variable "subnet_ids" {
  type = "list"
}

variable "root_volume_size" {
  default = "30"
}

variable "enabled" {
  default = false
}

variable "server_key" {}
