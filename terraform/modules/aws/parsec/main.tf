resource "aws_autoscaling_group" "default" {
  name = "parsec-${replace(var.name, "_", "-")}"

  vpc_zone_identifier = [
    "${var.subnet_ids}",
  ]

  desired_capacity          = "${var.enabled ? 1 : 0}"
  min_size                  = "0"
  max_size                  = "1"
  health_check_grace_period = "60"
  health_check_type         = "EC2"
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.default.name}"

  tag {
    key                 = "Name"
    value               = "parsec-${replace(var.name, "_", "-")}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "default" {
  name_prefix   = "parsec-${replace(var.name, "_", "-")}-"
  image_id      = "${var.ami}"
  instance_type = "g2.2xlarge"
  user_data     = "${data.template_file.default.rendered}"

  spot_price = "0.767"

  security_groups = [
    "${aws_security_group.default.id}",
  ]

  root_block_device {
    volume_size = "${var.root_volume_size}"
  }

  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "default" {
  name   = "parsec-${replace(var.name, "_", "-")}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 8000
    to_port     = 8040
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "parsec-${replace(var.name, "_", "-")}"
  }
}

data "template_file" "default" {
  template = "${file("${path.module}/user_data.tpl")}"

  vars {
    server_key = "${var.server_key}"
  }
}

data "aws_instance" "default" {
  count = "${var.enabled ? 1 : 0}"

  filter {
    name   = "tag:Name"
    values = ["parsec-${replace(var.name, "_", "-")}"]
  }

  depends_on = [
    "aws_autoscaling_group.default",
  ]
}
