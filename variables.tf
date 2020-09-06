variable "name" {
  type = string
  description = "Name prefix to tag workload objects"
  default = "workload"
}

variable "subnets" {
  type = list
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
