variable "name" {}

variable "amis" {
  type = "map"

  default = {
    "eu-west-1"    = "ami-ab0ff9d2"
    "eu-central-1" = "ami-626cc20d"
    "us-east-1"    = "ami-6dd6f916"
    "us-west-1"    = "ami-f0072c90"
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
