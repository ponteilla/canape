variable "name" {}

variable "ami" {
  default = "ami-ab0ff9d2"
}

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
