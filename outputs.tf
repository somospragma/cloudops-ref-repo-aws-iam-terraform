# output "iam_role_info" {
#   value = {for role in aws_iam_role.iam_role : role.tags_all.application_id => {"role_arn" : role.arn, "role_name" : role.tags_all.Name}}
# }