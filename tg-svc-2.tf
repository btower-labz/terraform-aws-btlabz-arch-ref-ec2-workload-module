resource "aws_lb_target_group" "service2" {
  name     = format("%s-service2-tg", local.name)
  port     = 8080
  protocol = "HTTP"

  health_check {
    enabled  = true
    interval = 30 # seconds
    path     = "/service2"
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
      "Service", "service2"
    ),
    var.tags
  )
}

resource "aws_lb_target_group_attachment" "service2_a" {
  target_group_arn = aws_lb_target_group.service2.arn
  target_id        = module.server_a.instance_id
  # port             = 8081
}

resource "aws_lb_listener_rule" "service2" {
  listener_arn = var.lb_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service2.arn
  }

  condition {
    path_pattern {
      values = [
        "/service2",
        "/service2/*"
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

output "tg_service2_arn" {
  value = aws_lb_target_group.service2.arn
}

