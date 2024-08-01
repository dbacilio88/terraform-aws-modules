# Terraform VPC Module

Este módulo de Terraform crea una VPC en AWS, incluyendo subredes públicas y privadas.

## Recursos Creados

- VPC
- Subredes Públicas
- Subredes Privadas
- (Opcional) Gateways y Route Tables (si se configura)

## Variables

- `vpc_cidr_block` (string, requerido): CIDR block para la VPC (por ejemplo, `10.0.0.0/16`).
- `public_subnet_count` (number, requerido): Número de subredes públicas a crear.
- `private_subnet_count` (number, requerido): Número de subredes privadas a crear.
- `availability_zones` (list(string), opcional): Lista de zonas de disponibilidad para distribuir las subredes.
- `tags` (map(string), opcional): Etiquetas a aplicar a los recursos.

## Outputs

- `public_subnet_ids`: ID de las subredes públicas.
- `private_subnet_ids`: ID de las subredes privadas.
- `vpc_id`: ID de la VPC creada.

## Ejemplo de Uso

```hcl
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block       = "10.0.0.0/16"
  public_subnet_count  = 2
  private_subnet_count = 2
  availability_zones = ["us-west-2a", "us-west-2b"]
  tags = {
    Name = "my-vpc"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

```

# **Documentación para el Módulo de EKS**

## Terraform EKS Module

Este módulo de Terraform crea un clúster de Amazon EKS y un grupo de nodos en AWS.

## Recursos Creados

- Clúster de EKS
- Grupo de Nodos EKS
- Roles de IAM para el clúster y los nodos
- Perfil de instancia de IAM para los nodos

## Variables

- `cluster_name` (string, requerido): Nombre del clúster de EKS.
- `cluster_version` (string, opcional): Versión de Kubernetes para el clúster (por defecto: `1.29`).
- `subnet_ids` (list(string), requerido): Lista de ID de subredes donde desplegar el clúster de EKS.
- `node_group_name` (string, requerido): Nombre del grupo de nodos EKS.
- `instance_types` (list(string), opcional): Tipos de instancias EC2 para los nodos (por defecto: `["t3.medium"]`).
- `desired_size` (number, opcional) : Número deseado de nodos en el grupo (por defecto: `2`).
- `max_size` (number, opcional): Número máximo de nodos en el grupo (por defecto: `3`).
- `min_size` (number, opcional): Número mínimo de nodos en el grupo (por defecto: `1`).
- `endpoint_public_access` (bool, opcional): Si el endpoint del clúster debe ser accesible públicamente (por
  defecto: `true`).
- `endpoint_private_access` (bool, opcional): Si el endpoint del clúster debe ser accesible privadamente (por
  defecto: `true`).
- `tags` (map(string), opcional) : Etiquetas a aplicar a los recursos.

## Outputs

- `cluster_id`: ID del clúster de EKS creado.
- `cluster_endpoint` : Endpoint del clúster de EKS.

## Ejemplo de Uso

```hcl
module "eks" {
  source = "./modules/eks"

  cluster_name            = "my-eks-cluster"
  cluster_version         = "1.21"
  subnet_ids              = module.vpc.public_subnet_ids
  node_group_name         = "my-node-group"
  instance_types = ["t3.medium"]
  desired_size            = 2
  max_size                = 3
  min_size                = 1
  endpoint_public_access  = true
  endpoint_private_access = true
  tags = {
    Environment = "production"
  }
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
```

## **Conclusión**

Estos archivos `README.md` te proporcionan una guía clara para configurar y usar los módulos de Terraform para VPC y
EKS. Asegúrate de mantener estos documentos actualizados con cualquier cambio en la configuración o en los requisitos
del módulo.
