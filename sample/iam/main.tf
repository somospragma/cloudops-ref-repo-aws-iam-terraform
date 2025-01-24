###########################################
############## IAM module #################
###########################################

module "iam" {
  source = "../../"
  providers = {
    aws.project = aws.alias01               #Write manually alias (the same alias name configured in providers.tf)
  }

  # Common configuration
  client      = var.client
  project     = var.project
  environment = var.environment

  # IAM configuration
  iam_config = var.iam_config
}
