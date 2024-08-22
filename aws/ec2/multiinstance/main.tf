resource "aws_instance" "my-instance" {
    count = length(var.instance_configs)
    ami = var.instance_configs[count.index].ami
    instance_type = var.instance_configs[count.index].instance_type
    subnet_id = var.instance_configs[count.index].instance_type
    security_groups = [var.instance_configs[count.index].security_groups]
    key_name = var.instance_configs[count.index].key_name
    user_data = var.instance_configs[count.index].platform == "linux" ? "${file(user_data.sh)}" : null
    root_block_device {
        volume_size = var.instance_configs[count.index].root_block_device.root_volume_size
        volume_type = var.instance_configs[count.index].root_block_device.root_volume_type
        encrypted = var.instance_configs[count.index].root_block_device.is_root_volume_encrypted
        kms_key_id = var.instance_configs[count.index].root_block_device.kms_key_id
    }  
    dynamic "ebs_block_device" {
        for_each = var.instance_configs[count.index].enable_ebs ? var.instance_configs[count.index].ebs_block_devices: []
        content  {
            device_name = var.ebs_device_name
            encrypted = var.ebs_volume_encrypted
            iops = ebs_block_device.value.ebs_iops
            volume_size = ebs_block_device.value.ebs_volume_size
            volume_type = ebs_block_device.value.ebs_volume_type
        }
      
    }
    tags = {
        name = var.instance_configs[count.index].hostname
        startdate = lower(formatdate("DD-MM-YYYY"),timestamp())
    }
    
}