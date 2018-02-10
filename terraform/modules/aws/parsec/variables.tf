variable "name" {}

variable "amis" {
  type = "map"

  default = {
    "eu-west-1"    = "ami-462ca93f"
    "eu-central-1" = "ami-9eed66f1"
    "us-east-1"    = "ami-e398f399"
    "us-west-1"    = "ami-696b6f09"
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
