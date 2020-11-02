# terraform {
#   required_providers {
#     ibm = {
#       source = "IBM-Cloud/ibm"
#       version = "1.14.0"
#     }
#   }
# }

variable ibmcloud_api_key {
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

variable pool_size {
}

data ibm_resource_group "resource_group" {
  name = "default"
}

resource ibm_container_cluster "advcluster" {
  name            = "advcluster"
  datacenter      = "dal10"
  machine_type    = "b3c.4x16"
  hardware        = "shared"
  public_vlan_id  = "2854312"
  private_vlan_id = "2854314"

  kube_version = "1.18"

  default_pool_size = var.pool_size

  public_service_endpoint  = "true"
  private_service_endpoint = "true"

  resource_group_id = data.ibm_resource_group.resource_group.id
}