module "vpc" {
  source = "../../modules/vpc"

  environment = "dev"
  cidr = "10.1.0.0/16"
  name = "pedro-dev-vpc"
  private_subnets = ["10.1.1.0/24"]
  public_subnets = ["10.1.2.0/24"]
}

module "database" {
  source = "../../modules/rds"

  environment = "dev"

  depends_on = [ module.vpc ]
}

module "servers" {
  source  = "pedrofenix19/awsec2/pedrodeniz"
  version = "0.0.4"
  environment = "dev"
  instance_name_prefix = "pedro"
  subnet_ids = module.vpc.public_subnets_ids
  ami = "ami-0ebfd941bbafe70c6"
}