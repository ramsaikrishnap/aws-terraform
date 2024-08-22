variable "region" {
  type = string
}
variable "owner" {
  type = string
}
variable "project" {
  type = string
}
variable "security_group_ids" {
  type = list(string)
}
variable "msk_cluster_name" {
  type = string
}
variable "msk_version" {
  type = string
}
variable "number_of_broker_nodes" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "ebs_volume_size" {
  type = string
}
variable "client_subnets" {
  type = list(string)
}
