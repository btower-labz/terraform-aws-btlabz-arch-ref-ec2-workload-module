variable "name" {
  type        = string
  description = "Name prefix to tag workload objects"
  default     = ""
}

variable "subnets" {
  type        = list
  description = "Subnets list. Any change here may cause EC2 instances recreation"
}

variable "instance_type" {
  default = "t3.nano"
}

variable "tags" {
  description = "Additional tags. E.g. environment, backup tags etc"
  type        = map
  default     = {}
}

variable "lb_listener_arn" {
  description = "ALB listener ARN to bind all the rules"
  type        = string
}

variable "zone_id" {
  description = "R53 zone identifier to use for records"
  type        = string
  default     = ""
}

variable "hostnames" {
  description = "Hostnames to add to rules. Default is *"
  type        = list
  default     = []
}
