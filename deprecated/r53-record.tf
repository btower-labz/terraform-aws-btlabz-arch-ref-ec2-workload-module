variable "zone_id" {
  description = "R53 zone identifier to use for records"
  type        = string
  default     = ""
}

data "aws_route53_zone" "primary" {
  count   = var.zone_id == "" ? 0 : 1
  zone_id = var.zone_id
}

locals {
  zone_name     = var.zone_id == "" ? "" : data.aws_route53_zone.primary[0].name
  workload_fqdn = var.zone_id == "" ? "" : format("%s.%s", local.name, local.zone_name)
}
