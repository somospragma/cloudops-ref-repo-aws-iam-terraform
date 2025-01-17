provider "aws" {
  alias = "alias01"
  region  = var.aws_region
  profile = var.profile
  default_tags {
    tags = var.common_tags
  }
}

terraform {
  required_version = ">= 0.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.31.0"
    }
  }
}
