output "iam_roles_info" {
  value = {
    for key, role in aws_iam_role.iam_role : 
    key => {
      "role_arn"             : role.arn,
      "role_name"            : role.name,
      "instance_profile_arn" : try(aws_iam_instance_profile.instance_profile[key].arn, null),
      "instance_profile_name": try(aws_iam_instance_profile.instance_profile[key].name, null),
      "tags"                 : role.tags_all,
    }
  }
}