variable "region" {
  type=string
  default = "us-east-1"
}
variable "project" {
  type=string
  default = "my-rds-project"
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
  default = "16.3"
}
variable "db_engine" {
  type=string
  default = "postgres"
}
variable "db_engine_version" {
  type=string
  default = "16"
}
variable "db_name" {
  type=string
  default = "pgdb"
}
variable "db_kms_key_id" {
  type=string
  default = "my-kms-key-id"
}
variable "db_port" {
  type=string
  default = "6379"
}
variable "db_iops" {
  type=string
  default = null
}
variable "db_allocated_storage" {
  type=number
  default = 200
}
variable "username" {
  type=string
  default = "pgadmin"
}
variable "password" {
  type=string
  default = "mypassword"
}
variable "db_storage_type" {
  type=string
  default = "gp3"
}
variable "db_multi_az" {
  type=bool
  default = true
}
variable "vpc_security_group_ids" {
  type=list(string)
  default = ["my-db-security-group-id"]
}
variable "db_instance_class" {
  type=string
  default = "db.r6g.large"
}
variable "db_license_model" {
  type = string
  default = null
}
variable "replica_instance_class" {
    type = string
    default = "db.r6g.large"
  
}