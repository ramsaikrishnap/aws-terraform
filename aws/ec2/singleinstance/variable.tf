variable "access_key" {
  type = string
  default = "your_access_key"
}
variable "secret_key" {
  type = string
  default = "your_secret_key"
}
variable "region" {
  type = string
  default = "us-east-1"
}
variable "ami" {
  type = string
  default = "your_ami_id"
}
variable "instance_type" {
  type = string
  default = "t3.micro"
}
variable "hostname" {
  type = string
  default = "my-ec2-instance"
}
variable "vpc_id" {
  type =string
  default = "your_vpc_id"
}
variable "subnet_id" {
  type = string
  default = "your_subent_id"
}
variable "key_name" {
  type = string
  default = "my-ssh-key"
}
variable "count" {
  type = number
  default = 1
}
variable "root_volume_size" {
  type = number
  default = 30
}
variable "root_volume_type" {
    type = string
    default = "gp3"
  
}
variable "kms_key_id" {
  type=string
  default = "your_kms_key_with_arn"
}
variable "device_name" {
  type = string
  default = "your_ebs_device_name"
}
variable "is_root_volume_encrypted" {
    type = bool
    default = true
}

variable "is_ebs_volume_encrypted" {
  type = bool
  default = true
}
variable "iops" {
  type=string
  default = "null"
}
variable "ebs_volume_size" {
  type = number
  default = 30
}
variable "ebs_volume_type" {
    type = string
    default = "gp3"
  
}
variable "cidr" {
  type = string
  default = "your_vpc_cidr"
}
