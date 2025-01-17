################################################################
# Module KMS
################################################################
module "IAM" {
  source = "./module/IAM"
  client      = var.client
  environment = var.environment
  
  iam_config = [
    {
      functionality = var.functionality
      application   = var.application
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
      ticket = var.ticket
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


  
