resource "aws_lb_target_group" "service1" {
  name     = format("%s-service1-tg", local.name)
  port     = 8080
  protocol = "HTTP"

  health_check {
    enabled  = true
    interval = 30 # seconds
    path     = "/service1"
    port     = 8080
    protocol = "HTTP"
    timeout  = 5
    matcher  = "200,302"
  }

  stickiness {
    type    = "lb_cookie"
    enabled = false
  }

  vpc_id = data.aws_vpc.main.id
  tags = merge(
    map(
      "Workload", "local.name",
      "Service", "service1"
    ),
    var.tags
  )
}

resource "aws_lb_target_group_attachment" "service1_a" {
  target_group_arn = aws_lb_target_group.service1.arn
  target_id        = module.server_a.instance_id
  # port             = 8081
}

resource "aws_lb_target_group_attachment" "service1_b" {
  target_group_arn = aws_lb_target_group.service1.arn
  target_id        = module.server_b.instance_id
  # port             = 8081
}

resource "aws_lb_listener_rule" "service1" {
  listener_arn = var.lb_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service1.arn
  }

  condition {
    path_pattern {
      values = [
        "/service1",
        "/service1/*"
      ]
    }
  }
}

output "tg_service1_arn" {
  value = aws_lb_target_group.service1.arn
}
