module "server_a" {
  source = "../../modules/appserver"
  subnet = element(var.subnets,0)
  tags   = var.tags
}

module "server_b" {
  source = "../../modules/appserver"
  subnet = element(var.subnets,1)
  tags   = var.tags
}

