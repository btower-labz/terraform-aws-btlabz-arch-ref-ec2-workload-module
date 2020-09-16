resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

locals {
  name = var.name == "" ? random_pet.name.id : var.name
}

module "server_a" {
  source = "git::https://github.com/btower-labz/terraform-aws-btlabz-arch-ref-ec2-appserver-module.git?ref=master"
  #source          = "../../modules/appserver"
  subnet          = element(local.subnets, 0)
  security_groups = [aws_security_group.workload.id]
  ami             = local.ami
  zone_id         = var.zone_id
  tags            = var.tags
}

module "server_b" {
  source = "git::https://github.com/btower-labz/terraform-aws-btlabz-arch-ref-ec2-appserver-module.git?ref=master"
  #source          = "../../modules/appserver"
  subnet          = element(local.subnets, 1)
  security_groups = [aws_security_group.workload.id]
  ami             = local.ami
  zone_id         = var.zone_id
  tags            = var.tags
}
