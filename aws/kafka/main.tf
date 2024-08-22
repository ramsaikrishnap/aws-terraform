provider "aws" {
  region = var.region
}
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
  tags = local.tags
}