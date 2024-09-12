locals {
  tags = {
    owner = var.owner
    project = var.project
  }

}

resource "aws_msk_cluster" "my_msk_cluster" {
  cluster_name = var.msk_cluster_name
  kafka_version = var.msk_version
  number_of_broker_nodes = var.number_of_broker_nodes
  broker_node_group_info {
    instance_type = var.instance_type
    storage_info {
      ebs_storage_info {
        volume_size = var.ebs_volume_size
      }
    }
    client_subnets = var.client_subnets
    security_groups = var.security_group_ids
  }
  configuration_info {
    arn = aws_msk_configuration.msk_config.arn
    revision = aws_msk_configuration.msk_config.latest_revision
  }
  tags = local.tags
}
resource "aws_msk_configuration" "msk_config" {
  kafka_versions = ["${var.msk_version}"]
  name = "${var.msk_cluster_name}-msk-config"
  server_properties = <<PROPERTIES
  num.io.threads=12
  num.network.threads=10
  num.partitions=1
  num.replica.fetchers=2
  PROPERTIES
  
}