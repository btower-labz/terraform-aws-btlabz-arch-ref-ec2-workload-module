variable "security_groups" {
  type        = list
  description = "Additional security groups for the workload"
  default     = []
}

variable "workload_egress_cidr" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "workload_ingress_cidr" {
  type    = list
  default = []
}

variable "workload_ingress_sgs" {
  type    = list
  default = []
}

locals {
  security_groups = sort(concat(
    list(aws_security_group.workload.id),
    distinct(compact(var.security_groups))
  ))
}

resource "aws_security_group" "workload" {
  name        = format("%s-wl-sg", local.name)
  description = "Allow Workload Access"
  vpc_id      = data.aws_vpc.main.id
  tags = merge(
    map(
      "Name", format("%s-sg", local.name)
    ),
    var.tags
  )
}

resource "aws_security_group_rule" "workload_default_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.workload_egress_cidr
  security_group_id = aws_security_group.workload.id
}

resource "aws_security_group_rule" "workload_in_http" {
  count             = length(var.workload_ingress_cidr) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = var.workload_ingress_cidr
  security_group_id = aws_security_group.workload.id
}

resource "aws_security_group_rule" "workload_in_health" {
  count             = length(var.workload_ingress_cidr) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = var.workload_ingress_cidr
  security_group_id = aws_security_group.workload.id
}

resource "aws_security_group_rule" "workload_in_cidr_https" {
  count             = length(var.workload_ingress_cidr) > 0 ? 1 : 0
  type              = "ingress"
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  cidr_blocks       = var.workload_ingress_cidr
  security_group_id = aws_security_group.workload.id
}

resource "aws_security_group_rule" "workload_in_sgs_http" {
  count                    = length(var.workload_ingress_sgs) > 0 ? length(var.workload_ingress_sgs) : 0
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = element(var.workload_ingress_sgs, count.index)
  security_group_id        = aws_security_group.workload.id
}

resource "aws_security_group_rule" "workload_in_sgs_health" {
  count                    = length(var.workload_ingress_sgs) > 0 ? length(var.workload_ingress_sgs) : 0
  type                     = "ingress"
  from_port                = 8081
  to_port                  = 8081
  protocol                 = "tcp"
  source_security_group_id = element(var.workload_ingress_sgs, count.index)
  security_group_id        = aws_security_group.workload.id
}

resource "aws_security_group_rule" "workload_in_sgs_https" {
  count                    = length(var.workload_ingress_sgs) > 0 ? length(var.workload_ingress_sgs) : 0
  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "tcp"
  source_security_group_id = element(var.workload_ingress_sgs, count.index)
  security_group_id        = aws_security_group.workload.id
}
