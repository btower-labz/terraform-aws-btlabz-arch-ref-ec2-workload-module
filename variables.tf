variable "name" {
  default = "workload"
}

variable "subnets" {
}

variable "instance_type" {
  default = "t3.nano"
}

variable "tags" {
  description = "Additional tags. E.g. environment, backup tags etc."
  type        = map
  default     = {}
}
