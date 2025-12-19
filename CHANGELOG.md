# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2025-12-19

### Añadido
- Instance Profile automático para roles de EC2 (requerido para EKS Auto Mode)
- Outputs `instance_profile_arn` e `instance_profile_name` en `iam_roles_info`

### Corregido
- Problema de nodos no creándose en EKS Auto Mode por falta de instance profile

## [1.0.1] - 2025-12-19

### Añadido
- Archivo `locals.tf` en directorio raíz (PC-IAC-001)
- Archivo `locals.tf` en `sample/iam/` con patrón PC-IAC-026
- Archivo `README.md` en `sample/iam/` con documentación completa
- Outputs funcionales en `sample/iam/outputs.tf`
- Campo `managed_policy_arns` y `additional_tags` en variables
- Validaciones en `variables.tf` para campos obligatorios y tipos de principal

### Cambiado
- **BREAKING CHANGE**: `iam_config` ahora es `map(object())` en lugar de `list(object())` (PC-IAC-007)
- Simplificado `main.tf` para usar `for_each` directamente con el map
- Mejorada nomenclatura de recursos usando `join()` en lugar de `tolist()`
- Actualizado `terraform.tfvars.sample` con formato de map

### Corregido
- Cumplimiento 100% con reglas PC-IAC (13/13 reglas)
- Estructura completa del módulo según PC-IAC-001
- Sample funcional completo según PC-IAC-026
- Uso correcto de `for_each` con map según PC-IAC-007

## [1.0.0] - 2023-09-20

### Añadido
- Versión inicial del módulo IAM
- Soporte para roles y políticas IAM
- Soporte para políticas administradas de AWS
- Configuración de providers con alias

