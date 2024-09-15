locals {
  tags = {
    owner = var.owner
    project = var.project
  }

}

data "aws_rds_engine_version" "db_version"{
    engine = var.db_engine
    version = var.db_engine_version
}
resource "aws_db_subnet_group" "dbsubnetgrp" {
  name = "${var.db_instance_name}-sng"
  subnet_ids = var.subnet_ids
  tags = local.tags
}

resource "aws_db_option_group" "dboptiongrp" {
  name = "${var.db_instance_name}-og"
  engine_name = var.db_engine
  major_engine_version = var.db_major_engine_version
}
resource "aws_db_parameter_group" "dbparametergrp" {
  name = "${var.db_instance_name}-pg"
  family = data.aws_rds_engine_version.db_version.parameter_group_family
  tags = local.tags
}

resource "aws_db_instance" "db" {
  identifier = var.db_instance_name
  instance_class = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  engine = var.db_engine
  engine_version = var.db_engine_version
  username = var.username
  password = var.password
  storage_type = var.db_storage_type
  multi_az = var.db_multi_az
  storage_encrypted = true
  kms_key_id = var.db_kms_key_id
  db_name=var.db_name
  port = var.db_port
 #*** license_model = var.db_license_model  # This value should be used only for ORACLE RDS Instance types.
  db_subnet_group_name = aws_db_option_group.dboptiongrp.name
  vpc_security_group_ids = var.vpc_security_group_ids
  parameter_group_name = aws_db_parameter_group.dbparametergrp.name
  iops = var.db_iops
  skip_final_snapshot = true
  auto_minor_version_upgrade = true
  tags = local.tags
}
