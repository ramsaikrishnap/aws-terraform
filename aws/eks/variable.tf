variable "region" {
  type = string
}
variable "eks_cluster_name" {
  type = string
}
variable "eks_cluster_version" {
  type = string
}
variable "security_group_ids" {
  type = list(string)
}
variable "endpoint_private_access" {
  type = bool
  default = true
  description = "Indicates whether or not the Amazon EKS private API Server endpoint is enabled."
}
variable "endpoint_public_access" {
  type = bool
  default = false
  description = "Indicates whether or not the Amazon EKS public API Server endpoint is enabled."
}
variable "subnet_ids" {
  type = list(string)
  description = "List of subnet IDs. Better use 2 different subnet is different AZs."
}
variable "owner" {
  type = string
}
variable "project" {
  type = string
}