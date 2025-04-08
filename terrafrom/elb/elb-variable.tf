variable "vpc_id" {
    description = "the id of vpc"
}

variable "public_SG_id" {
  description = "public Security grouo"
}

variable "private_SG_id" {
  description = "private Security grouo"
}
variable "subnet_public_AZ1_id" {
  description = "subnet public AZ1 id"
}

variable "subnet_public_AZ2_id" {
  description = "subnet public AZ2 id"
}

variable "subnet_private_AZ1_id" {
  description = "subnet private AZ1 id"
}

variable "subnet_private_AZ2_id" {
  description = "subnet private AZ2 id"
}