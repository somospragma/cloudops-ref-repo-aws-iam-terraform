###########################################
########### IAM Resources #################
###########################################

resource "aws_iam_role" "iam_role" {
  provider = aws.project
  for_each = var.iam_config
  
  name               = join("-", [var.client, var.project, var.environment, "role", each.value.service, each.value.application, each.value.functionality])
  path               = each.value.path
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.key].json
  
  tags = merge(
    { 
      Name           = join("-", [var.client, var.project, var.environment, "role", each.value.service, each.value.application, each.value.functionality])
      application_id = each.value.application
    },
    each.value.additional_tags
  )
}

data "aws_iam_policy_document" "assume_role" {
  provider = aws.project  
  for_each = var.iam_config

  statement {
    actions = each.value.assume_role_actions
    principals {
      type        = each.value.type
      identifiers = each.value.identifiers
    }

    dynamic "condition" {
      for_each = each.value.principal_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "dynamic_policy" {
  provider = aws.project
  for_each = {
    for role_key, role in var.iam_config : 
    role_key => role
    if length(role.policies) > 0 && length(role.policies[0].policy_statements) > 0
  }
  
  dynamic "statement" {
    for_each = flatten([
      for policy in each.value.policies : policy.policy_statements
    ])
    content {
      sid       = statement.value.sid
      actions   = statement.value.actions
      resources = statement.value.resources
      effect    = statement.value.effect

      dynamic "condition" {
        for_each = statement.value.condition
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_policy" "policy" {
  provider = aws.project
  for_each = {
    for role_key, role in var.iam_config : 
    role_key => role
    if length(role.policies) > 0 && length(role.policies[0].policy_statements) > 0
  }
  
  name        = join("-", [var.client, var.project, var.environment, "policy", each.value.service, each.value.application, each.value.functionality])
  description = each.value.policies[0].policy_description
  policy      = data.aws_iam_policy_document.dynamic_policy[each.key].json
  
  tags = merge(
    { 
      Name = join("-", [var.client, var.project, var.environment, "policy", each.value.service, each.value.application, each.value.functionality])
    },
    each.value.additional_tags
  )
}

resource "aws_iam_role_policy_attachment" "attachment" {
  provider = aws.project
  for_each = {
    for role_key, role in var.iam_config : 
    role_key => role
    if length(role.policies) > 0 && length(role.policies[0].policy_statements) > 0
  }
  
  role       = aws_iam_role.iam_role[each.key].name
  policy_arn = aws_iam_policy.policy[each.key].arn
}

# Atachar Politicas Administradas AWS
resource "aws_iam_role_policy_attachment" "managed_policy_attachment" {
  provider = aws.project
  for_each = {
    for item in flatten([
      for role_key, role in var.iam_config : [
        for arn in role.managed_policy_arns : {
          role_key   = role_key
          policy_arn = arn
        }
      ]
    ]) : "${item.role_key}-${replace(item.policy_arn, "/[/:]/", "-")}" => item
  }

  role       = aws_iam_role.iam_role[each.value.role_key].name
  policy_arn = each.value.policy_arn
}