resource "aws_lb_target_group" "main" {
  name     = format("%s-tg", var.name)
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "server_a" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = module.server_a.instance_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "server_b" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = module.server_a.instance_id
  port             = 80
}