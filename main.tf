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



############################################################
# GET VCENTER MOID
############################################################




############################################################
# CREATE K8S INFRA PROVIDER
############################################################




############################################################
# CREATE MASTER NODE GROUP FOR CLUSTER
############################################################




############################################################
# CREATE WORKER NODE GROUP FOR CLUSTER
############################################################




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


