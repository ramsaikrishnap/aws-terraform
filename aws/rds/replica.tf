resource "aws_db_instance" "replica" {
  replicate_source_db = aws_db_instance.db.identifier
  identifier = "${aws_db_instance.db.identifier}-readreplica"
  instance_class = var.replica_instance_class
  engine = aws_db_instance.db.engine
  engine_version = aws_db_instance.db.engine_version
  multi_az = aws_db_instance.db.multi_az
  port = aws_db_instance.db.port
  vpc_security_group_ids = aws_db_instance.db.vpc_security_group_ids
  parameter_group_name = aws_db_instance.db.parameter_group_name
  option_group_name = aws_db_instance.db.option_group_name
  iops = aws_db_instance.db.iops
  backup_retention_period = aws_db_instance.db.backup_retention_period
  backup_window = aws_db_instance.db.backup_window
  skip_final_snapshot = true
  auto_minor_version_upgrade = true
  tags = aws_db_instance.db.tags
  depends_on = [ aws_db_instance.db ]
}