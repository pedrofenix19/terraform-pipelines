module "vpc" {
  source = "../../modules/vpc"

  environment = "prod"
  cidr = "10.1.0.0/16"
  name = "pedro-vpc"
  private_subnets = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
  public_subnets = ["10.1.2.0/24", "10.1.3.0/24", "10.1.4.0/24"]
}

module "database" {
  source = "../../modules/rds"

  environment = "prod"
  rds_instance_name = "pedro-rds"
  rds_subnets_ids = module.vpc.private_subnets_ids
}

module "servers" {
  source  = "pedrofenix19/awsec2/pedrodeniz"
  version = "0.0.4"
  environment = "prod"
  instance_name_prefix = "pedroprod"
  subnet_ids = module.vpc.public_subnets_ids
  ami = "ami-0ebfd941bbafe70c6"
  instances_per_subnet = 2
}