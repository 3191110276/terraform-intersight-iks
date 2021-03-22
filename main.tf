############################################################
# ADD THIRD PARTY PROVIDERS
############################################################
terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.0"
    }
  }
}


############################################################
# GET ORGANIZATION MOID
############################################################
data "intersight_organization_organization" "organization" {
  name = var.org
}


############################################################
# GET K8S VERSION MOID
############################################################
data "intersight_kubernetes_version" "version" {
  kubernetes_version = join("", ["v", var.k8s_version])
}


############################################################
# CREATE K8S VERSION POLICY
############################################################
resource "intersight_kubernetes_version_policy" "k8s_version" {
  
  name = "${var.cluster_name}_version"

  nr_version {
    object_type = "kubernetes.Version"
    moid        = data.intersight_kubernetes_version.version.moid
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.moid
  }
}


############################################################
# CREATE K8S SYS CONFIG POLICY
############################################################
resource "intersight_kubernetes_sys_config_policy" "k8s_sysconfig" {

  name = "${var.cluster_name}_sysconfig"

  dns_servers = var.dns_servers

  ntp_servers = var.ntp_servers
  timezone    = var.timezone

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.moid
  }
}


############################################################
# CREATE K8S NETWORK POLICY
############################################################
resource "intersight_kubernetes_network_policy" "k8s_network" {

  name = "${var.cluster_name}_network"

  pod_network_cidr = var.pod_network_cidr
  service_cidr     = var.service_cidr

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.moid
  }
}


############################################################
# CREATE K8S CONTAINER RUNTIME POLICY
############################################################



############################################################
# CREATE K8S NODE TYPE POLICY
############################################################
resource "intersight_kubernetes_virtual_machine_instance_type" "k8s_nodetype" {

  name = "${var.cluster_name}_nodetype"

  cpu = var.cpu
  memory = var.memory
  disk_size = var.disk_size

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.moid
  }
}


############################################################
# GET VCENTER MOID
############################################################
data "intersight_asset_target" "infra_target" {
  name = var.vcenter_target
}


############################################################
# CREATE K8S INFRA PROVIDER
############################################################
resource "intersight_kubernetes_virtual_machine_infrastructure_provider" "k8s_infraprovider" {

  name = "${var.cluster_name}_infraprovider"

  infra_config {
    object_type = "kubernetes.EsxiVirtualMachineInfraConfig"
    interfaces  = var.vcenter_network
    additional_properties = jsonencode({
      Datastore    = var.vcenter_datastore
      Cluster      = var.vcenter_cluster
      Passphrase   = var.vcenter_passphrase
    })
  }

  instance_type {
      object_type = "kubernetes.VirtualMachineInstanceType"
      moid = intersight_kubernetes_virtual_machine_instance_type.k8s_nodetype.moid
  }

  target {
    object_type = "asset.DeviceRegistration"
    moid = data.intersight_asset_target.infra_target.registered_device[0].moid

  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization.moid
  }
}


############################################################
# GET IP POOL MOID
############################################################
data "intersight_ippool_pool" "k8s_pool" {
  name = var.ip_pool
}


############################################################
# CREATE MASTER NODE GROUP FOR CLUSTER
############################################################
resource "intersight_kubernetes_node_group_profile" "k8s_mastergroup" {

  name = "${var.cluster_name}_mastergroup"

  node_type = "Master"

  desiredsize = var.master_count

  kubernetes_version {
    moid = intersight_kubernetes_version_policy.k8s_version.moid
    object_type = "kubernetes.VersionPolicy"
  }

  infra_provider {
    moid = intersight_kubernetes_virtual_machine_infrastructure_provider.k8s_infraprovider.moid
    object_type = "kubernetes.VirtualMachineInfrastructureProvider"
  }

  ip_pools {
    moid = intersight_ippool_pool.k8s_pool.moid
    object_type = "ippool.Pool"
  }

  cluster_profile {
    object_type = "kubernetes.ClusterProfile"
    moid = intersight_kubernetes_cluster_profile.k8s_cluster.id
  }
}


############################################################
# CREATE WORKER NODE GROUP FOR CLUSTER
############################################################
resource "intersight_kubernetes_node_group_profile" "k8s_workergroup" {

  name = "${var.cluster_name}_workergroup"

  node_type = "Worker"

  desiredsize = var.worker_count

  kubernetes_version {
    moid = intersight_kubernetes_version_policy.k8s_version.moid
    object_type = "kubernetes.VersionPolicy"
  }

  infra_provider {
    moid = intersight_kubernetes_virtual_machine_infrastructure_provider.k8s_infraprovider.moid
    object_type = "kubernetes.VirtualMachineInfrastructureProvider"
  }

  ip_pools {
    moid = intersight_ippool_pool.k8s_pool.moid
    object_type = "ippool.Pool"
  }

  cluster_profile {
    object_type = "kubernetes.ClusterProfile"
    moid = intersight_kubernetes_cluster_profile.k8s_cluster.moid
  }
}


############################################################
# CREATE K8S PROFILE
############################################################




############################################################
# WAIT FOR KUBECONFIG TO BE CREATED
############################################################




############################################################
# GET CLUSTER INFORMATION
############################################################




############################################################
# EXTRACT KUBECONFIG
############################################################




############################################################
# DEFINE OUTPUT
############################################################


