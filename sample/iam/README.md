# Sample: IAM Module

Este directorio contiene un ejemplo funcional de uso del módulo IAM siguiendo las mejores prácticas de PC-IAC.

## Estructura

```
sample/iam/
├── data.tf              # Data sources (AWS caller identity)
├── locals.tf            # Transformaciones de datos (PC-IAC-026)
├── main.tf              # Llamada al módulo IAM
├── outputs.tf           # Outputs del ejemplo
├── providers.tf         # Configuración de providers
├── terraform.tfvars.sample  # Valores de ejemplo
├── variables.tf         # Variables del ejemplo
└── README.md           # Esta documentación
```

## Uso

1. **Copiar el archivo de variables:**
   ```bash
   cp terraform.tfvars.sample terraform.tfvars
   ```

2. **Editar terraform.tfvars:**
   - Actualizar `profile` con tu perfil AWS
   - Actualizar `ACCOUNT_NUMBER` y `ROLE_NAME` en providers.tf
   - Configurar `iam_config` según tus necesidades

3. **Inicializar Terraform:**
   ```bash
   terraform init
   ```

4. **Validar configuración:**
   ```bash
   terraform validate
   terraform plan
   ```

5. **Aplicar cambios:**
   ```bash
   terraform apply
   ```

## Ejemplo de Configuración

El ejemplo crea un rol IAM para ECS con políticas personalizadas para acceso a S3 y DynamoDB:

- **Rol:** `{client}-{project}-{environment}-role-ecs-app01-s3`
- **Políticas:** Acceso a S3 (ListBucket, GetObject) y DynamoDB (GetItem, Query, PutItem)
- **Principal:** AWS (con condiciones)

## Patrón PC-IAC-026

Este ejemplo sigue el patrón de transformación:
```
terraform.tfvars → variables.tf → data.tf → locals.tf → main.tf
```

Si necesitas inyectar valores dinámicos (ARNs, IDs de recursos), usa `locals.tf` para las transformaciones.

## Managed Policies

Para adjuntar políticas administradas de AWS, usa el campo `managed_policy_arns`:

```hcl
iam_config = [
  {
    # ... otras configuraciones
    managed_policy_arns = [
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
    ]
  }
]
```

## Outputs

- `iam_roles_info`: Información de todos los roles creados (ARN, nombre, tags)
