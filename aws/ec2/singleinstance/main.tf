
locals {
  tags = {
  name = var.hostname
  startdate = lower(formatdate("DD-MM-YYYY"),timestamp())
  }
}
data "aws_vpc" "my-vpc" {
 id = var.vpc_id 
}

resource "aws_security_group" "my-instance-sg" {
  name= "${var.hostname}-sg"
  vpc_id = var.vpc_id
  tags = local.tags
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [aws_vpc.my-vpc.cidr_blocks]
    }
    
    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "my-instance" {

  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_groups = [aws_security_group.my-instance-sg.id]
  key_name = var.key_name
  user_data = "${file("user-data.sh")}"
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted = var.is_root_volume_encrypted
    kms_key_id = var.kms_key_id
  }
  ebs_block_device {
    device_name = var.device_name
    encrypted = var.is_ebs_volume_encrypted
    iops = var.iops
    kms_key_id = var.kms_key_id
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }
  tags = local.tags
}
