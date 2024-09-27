variable "environment" {
  type        = string
  description = "Environment"
}

variable "rds_instance_name" {
  type = string
  description = "Name of the RDS instance"
  default = "default"

  validation {
    condition = var.rds_instance_name != "pedro"
    error_message = "El nombre de la instancia debe ser distinto de pedro"
  }
}

variable "rds_subnets_ids" {
  type = list(string)
  description = "Subnets to deploy RDS"
  default = []
}

locals {
  # si entorno es prod entonces rds_instance_name debe ser distinto a "default". P => Q === !P || Q
  validate_rds_instance_name = var.environment != "prod" || var.rds_instance_name != "default"  ? true: tobool("La variable rds_instance_name debe ser especificada en entorno prod")
  validate_rds_subnets = var.environment != "prod" || length(var.rds_subnets_ids) >= 2 ? true : tobool("Para entorno prod deben especificarse 2 o más subnet ids")
}