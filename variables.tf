variable "resource_group_name" {
  default = "myTFResourceGroupNew"
}
variable "workspace_name" {
  description = "Name of the source workspace to query."
  type        = string
  default     = "learn-hcp-terraform"
}

variable "organization_name" {
  description = "Name of the HCP Terraform organization with the source workspace"
  type        = string
  default = "AdriTanulTF"
}
