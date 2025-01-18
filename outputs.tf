output "iam_role_info" {
  description = "Map of IAM role information containing ARN, name and tags"
  value = {
    for functionality_app_service, role in aws_iam_role.iam_role : functionality_app_service => {
      arn = role.arn
      name = role.name
      tags = role.tags
    }
  }
}