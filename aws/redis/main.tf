resource "aws_elasticache_replication_group" "my_redis_cluster" {
  description = "Elastic Cache group created using Terraform"
  engine = "redis"
  engine_version = var.redis_version
  port = var.port
  replication_group_id = var.redis_cluster_name
  num_cache_clusters = var.num_cache_clusters
  node_type = var.node_type
  kms_key_id = var.kms_key_id
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  automatic_failover_enabled = var.automatic_failover_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token = var.auth_token
  subnet_group_name = aws_elasticache_subnet_group.sg.name
  security_group_ids = []
  parameter_group_name = aws_elasticache_parameter_group.pg.name
  
  apply_immediately = var.apply_immediately
  tags = {
    name = var.redis_cluster_name
    project = var.project
    environment = var.environment
  }

}

resource "aws_elasticache_parameter_group" "pg" {
  name="${var.redis_cluster_name}-parameter-group"
  family = var.parameter_group_family
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elasticache_subnet_group" "sg" {
  name = "${var.redis_cluster_name}-subent-group"
  subnet_ids = var.subnet_ids
}