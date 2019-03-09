resource "aws_launch_configuration" "launch_webserver_ami" {
  name          = "webserver_as"
  image_id      = "ami-07b7a0b24befd05fa"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.sg_webserver1.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "as_webserver" {
  name                 = "webserve_asg"
  launch_configuration = "${aws_launch_configuration.launch_webserver_ami.name}"
  availability_zones   = ["${var.az_list}"]
  min_size             = 2
  max_size             = 2
  target_group_arns    = ["${aws_lb_target_group.webserver_target.arn}"]
  vpc_zone_identifier  = ["${aws_subnet.public.*.id}"]

  lifecycle {
    create_before_destroy = true
  }
}
