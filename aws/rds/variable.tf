variable "region" {
  type=string
  default = "us-east-1"
}
variable "project" {
  type=string
  default = "my-first-project"
}
variable "owner" {
  type=string
  default = "xyz@gmail.com"
}
variable "db_instance_name" {
  type=string
  default = "my-db-instance"
}
variable "subnet_ids" {
  type= list(string)
  default = ["subnet-1","subnet-2"]
}
variable "db_major_engine_version" {
  type=string
  default = "my-db-instance"
}
variable "db_engine" {
  type=string
  default = "my-db-instance"
}
variable "db_engine_version" {
  type=string
  default = "my-db-instance"
}
variable "db_name" {
  type=string
  default = "my-db-instance"
}
variable "db_kms_key_id" {
  type=string
  default = "my-db-instance"
}
variable "db_port" {
  type=string
  default = "my-db-instance"
}
variable "db_iops" {
  type=string
  default = "my-db-instance"
}
variable "db_allocated_storage" {
  type=string
  default = "my-db-instance"
}
variable "username" {
  type=string
  default = "my-db-instance"
}
variable "password" {
  type=string
  default = "my-db-instance"
}
variable "db_storage_type" {
  type=string
  default = "my-db-instance"
}
variable "db_multi_az" {
  type=string
  default = "my-db-instance"
}
variable "vpc_security_group_ids" {
  type=list(string)
  default = "my-db-instance"
}
variable "db_instance_class" {
  type=string
  default = "my-db-instance"
}
variable "db_license_model" {
  type = string
  default = "value"
}
variable "replica_instance_class" {
    type = string
    default = "value"
  
}