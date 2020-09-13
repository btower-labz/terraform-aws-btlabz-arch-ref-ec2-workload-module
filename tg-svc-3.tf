resource "aws_lb_target_group" "service3" {
  name     = format("%s-service3-tg", local.name)
  port     = 8080
  protocol = "HTTP"

  health_check {
    enabled  = true
    interval = 30 # seconds
    path     = "/service3"
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
      "Service", "service3"
    ),
    var.tags
  )
}

resource "aws_lb_target_group_attachment" "service3_b" {
  target_group_arn = aws_lb_target_group.service3.arn
  target_id        = module.server_b.instance_id
  # port             = 8081
}

resource "aws_lb_listener_rule" "service3" {
  listener_arn = var.lb_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service3.arn
  }

  condition {
    path_pattern {
      values = [
        "/service3",
        "/service3/*"
      ]
    }
  }

  dynamic "condition" {
    for_each = var.hostnames
    content {
      host_header {
        values = [condition.value]
      }
    }
  }

}

output "tg_service3_arn" {
  value = aws_lb_target_group.service3.arn
}
