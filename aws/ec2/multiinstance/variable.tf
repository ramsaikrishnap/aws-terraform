variable "instance_configs" {
  type = list(object({
    name = string
    ami = string
    instance_type =string
    subnet_id = string
    security_groups = string
    platform = string
    key_name = string
    root_block_device = list(object({
      root_volume_size = number
      root_volume_type = string
      is_root_volume_encrypted = bool
      kms_key_id = string
    }))
    enable_ebs = bool
    ebs_block_devices = list(object({
        ebs_volume_size = number
        ebs_volume_type = string
        ebs_kms_key_id = string
        ebs_iops = string
    }))
  }))
}
variable "ebs_volume_encrypted" {
    type = bool
    default = true
  
}
variable "ebs_device_name" {
  type = string
  default = "your_ebs_device_name"
}
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
