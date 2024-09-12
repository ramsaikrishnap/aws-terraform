output "rds_endpoint" {
  value=aws_db_instance.db.endpoint
}
output "rds_replica_endpoint" {
  value = aws_db_instance.replica.endpoint
}