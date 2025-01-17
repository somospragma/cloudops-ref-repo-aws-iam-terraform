###############################################################
# Variables Globales
###############################################################


aws_region        = "us-east-1"
profile           = "pra_idp_dev"
environment       = "dev"
client            = "pragma"
project           = "hefesto"
service_name_rds  = "rds"
service_name_kms  = "kms"


common_tags = {
  environment   = "dev"
  project-name  = "Modulos Referencia"
  cost-center   = "-"
  owner         = "cristian.noguera@pragma.com.co"
  area          = "KCCC"
  provisioned   = "terraform"
  datatype      = "interno"
}

functionality = "s3-dynamo"  #aqui se pone la funcionalidad esperada por el rol
application   = "hefesto"
path          = "/service-role/"
type          = "AWS"
test          = "StringLike"
variable      = "aws:RequestTag/project"
values        = ["hefesto"]