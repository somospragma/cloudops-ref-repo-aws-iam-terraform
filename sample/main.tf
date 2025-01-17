################################################################
# Module IAM
################################################################
module "IAM" {
  source = "../"
  providers = {
    aws.project = aws.alias01 #Write manually alias (the same alias name configured in providers.tf)
  }
  client      = var.client
  environment = var.environment
  project     = var.project

  iam_config = [
    {
      functionality = var.functionality
      application   = var.application
      service       = var.service
      path          = var.path
      type          = var.type
      identifiers   = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      principal_conditions = [
        {
          test     = var.test
          variable = var.variable
          values   = var.values
        }
      ]
      policies = [
        {
          policy_description = "Policy to allow access to S3 and DynamoDB"
          policy_statements = [
            {
              sid       = "AllowS3Access"
              actions   = ["s3:ListBucket", "s3:GetObject"]
              resources = ["*"]
              effect    = "Allow"
              condition = []
            },
            {
              sid       = "AllowDynamoDBAccess"
              actions   = ["dynamodb:GetItem", "dynamodb:Query", "dynamodb:PutItem"]
              resources = ["*"]
              effect    = "Allow"
              condition = []
            }
          ]
        }
      ]
    }
  ]
}



