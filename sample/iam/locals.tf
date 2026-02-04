###########################################
########### Local Variables ###############
###########################################

# Patrón PC-IAC-026: Transformación de datos
# terraform.tfvars → variables.tf → data.tf → locals.tf → main.tf

# En este ejemplo, iam_config se pasa directamente al módulo sin transformaciones.
# Si necesitas inyectar valores dinámicos (ARNs, IDs), hazlo aquí:

locals {
  # Ejemplo de transformación (actualmente no se usa):
  # iam_config_transformed = [
  #   for config in var.iam_config : merge(config, {
  #     # Inyectar valores dinámicos aquí
  #   })
  # ]
}
