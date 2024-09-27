resource "local_file" "dev_database" {
  count    = var.environment == "dev" ? 1 : 0
  filename = "dev_database.sqlite"
  content = "hola"
}


module "prod_database" {
  source = "terraform-aws-modules/rds/aws"

  count = var.environment == "prod" ? 1 : 0

  identifier = var.rds_instance_name

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  port     = "3306"


  tags = {
    Environment = var.environment
  }

#   # DB subnet group
  create_db_subnet_group = true
    subnet_ids = var.rds_subnets_ids
    # db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

#   # DB parameter group
  family = "mysql5.7"

#   # DB option group
  major_engine_version = "5.7"
}
