module "secret" {
  source = "git::https://github.com/demmonico/tf-modules-aws-sm-secret.git?ref=1.0.0"

  for_each = { for _, cnf in var.secrets_config : cnf.secret_name => cnf }

  secret_name            = each.value.secret_name
  secret_value_init_keys = each.value.secret_keys
}
