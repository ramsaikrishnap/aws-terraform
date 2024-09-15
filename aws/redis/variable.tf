variable "region" {
  type=string
  default = "us-east-1"
}
variable "project" {
  type=string
  default = "my-redis-project"
}
variable "environment" {
  type=string
  default = "demo"
}
variable "redis_cluster_name" {
  type=string
  default = "my-db-instance"
}
variable "auth_token" {
  type=string
  default = "your-auth-token"
}
variable "apply_immediately" {
  type=string
  default = "true"
}
variable "parameter_group_family" {
  type=string
  default = "redis7"
}

variable "transit_encryption_enabled" {
  type=bool
  default = true
}
variable "at_rest_encryption_enabled" {
  type=bool
  default = true
}
variable "auto_minor_version_upgrade" {
  type=bool
  default = true
}
variable "automatic_failover_enabled" {
  type=string
  default = true
}
variable "redis_version" {
  type=string
  default = "7.1"
}
variable "security_group_name" {
  type = list()
}
variable "num_cache_clusters" {
  type=string
  default = "2"
}
variable "node_type" {
  type = string
  default = "cache.m4.large"
}
variable "kms_key_id" {
  type=string
  default = "my-kms-key-id"
}
variable "port" {
  type=number
  default = 6379
}
variable "subnet_ids" {
  type= list(string)
  default = ["subnet-1","subnet-2"]
}
variable "security_group_ids" {
  type= list(string)
  default = ["sg-1","sg-2"]
}