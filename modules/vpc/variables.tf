variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "subnet_public_cidr" {
  description = "A list of CIDR blocks for subnets public."
  type = list(string)
}
variable "subnet_private_cidr" {
  description = "A list of CIDR blocks for subnets private."
  type = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones for subnets."
  type = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IPs on launch."
  type        = bool
  default     = true
}