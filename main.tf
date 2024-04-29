# --- root/main.tf ---

module "networking" {
  source   = "./networking"
  vpc_cidr = local.vpc_cidr
  #number of subnets to generate using the cidrsubnet function  
  public_sn_count = 2
  max_subnets     = 5
  access_ip       = var.access_ip
  security_groups = local.security_groups
  #for loop to generate subnet numbers using cidrsubnet function 
  public_cidrs = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
}

module "compute" {
  source          = "./compute"
  public_sg       = module.networking.public_sg
  public_subnets  = module.networking.public_subnets
  instance_count  = 3
  instance_type   = "t2.small"
  public_key_path = var.public_key_path
  key_name        = "trkey"
  
}

