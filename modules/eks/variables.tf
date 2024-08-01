# variables.tf

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.21"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type = list(string)
}

variable "node_group_name" {
  description = "The name of the EKS node group."
  type        = string
}

variable "instance_types" {
  description = "List of instance types for the EKS node group."
  type = list(string)
  default = ["t3.medium"]
}

variable "desired_size" {
  description = "The desired number of nodes in the node group."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of nodes in the node group."
  type        = number
  default     = 3
}

variable "min_size" {
  description = "The minimum number of nodes in the node group."
  type        = number
  default     = 1
}

variable "endpoint_public_access" {
  description = "Whether the EKS cluster endpoint is publicly accessible."
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Whether the EKS cluster endpoint is privately accessible."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources."
  type = map(string)
  default = {}
}
variable "capacity_type" {
  description = "Capacity type."
  type        = string
}
