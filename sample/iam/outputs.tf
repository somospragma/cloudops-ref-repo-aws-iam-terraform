###########################################
############### Outputs ###################
###########################################

output "iam_roles_info" {
  description = "Information about created IAM roles including ARNs and names"
  value       = module.iam.iam_roles_info
}
