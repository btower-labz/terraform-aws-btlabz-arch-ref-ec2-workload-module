module "server_a" {
  source = "../../modules/appserver"
  subnet = element(local.subnets, 0)
  tags   = var.tags
}

module "server_b" {
  source = "../../modules/appserver"
  subnet = element(local.subnets, 1)
  tags   = var.tags
}
