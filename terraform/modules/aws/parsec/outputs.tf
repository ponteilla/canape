output "instance_public_ip" {
  value = "${data.aws_instance.default.public_ip}"
}
