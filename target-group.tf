resource "aws_lb_target_group" "main" {
  name     = format("%s-tg", local.name)
  port     = 8081
  protocol = "HTTP"

  health_check {
    enabled  = true
    interval = 30 # seconds
    path     = "/"
    port     = 8081
  }

  stickiness {
    type    = "lb_cookie"
    enabled = false
  }

  vpc_id = data.aws_vpc.main.id
  tags = merge(
    map(
      "Workload", "local.name"
    ),
    var.tags
  )
}

resource "aws_lb_target_group_attachment" "server_a" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = module.server_a.instance_id
  # port             = 8081
}

resource "aws_lb_target_group_attachment" "server_b" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = module.server_b.instance_id
  # port             = 8081
}
