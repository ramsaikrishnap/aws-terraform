output "kafka_arn" {
  value=aws_msk_cluster.my_msk_cluster.arn
}
output "kafka_config_arn" {
  value=aws_msk_configuration.msk_config.arn
}