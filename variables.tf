variable "org" {
  type        = string
  default     = "default"
  description = "Intersight organization which the cluster belongs to."
}

variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster in Intersight. This property is used to name all policies and profiles."
}

variable "k8s_version" {
  type        = string
  default     = "1.18.12"
  description = "The Kubernetes version that the created cluster will be based on."
}

variable "dns_servers" {
  type        = list
  description = "A list of DNS servers that will be used for configuring the Kubernetes cluster."
}

variable "ntp_servers" {
  type        = list
  description = "A list of NTP servers that will be used for configuring the Kubernetes cluster."
}

variable "timezone" {
  type        = string
  description = "A timezone that will be used for configuring the Kubernetes cluster."
}

variable "pod_network_cidr" {
  type        = string
  default     = "172.16.0.0/17"
  description = "The CIDR used for the Kubernetes Pod network."
}

variable "service_cidr" {
  type        = string
  default     = "172.16.128.0/17"
  description = "The CIDR used for the Kubernetes Service network."
}

variable "cpu" {
  type        = string
  default     = "4"
  description = "The amount of CPU cores that will be assigned to each created Kubernetes Node/VM."
}

variable "memory" {
  type        = string
  default     = "4096"
  description = "The amount of memory that will be assigned to each created Kubernetes Node/VM."
}

variable "disk_size" {
  type        = string
  default     = "25"
  description = "The disk size of each created Kubernetes Node/VMs."
}

variable "vcenter_target" {
  type        = string
  description = "The target name of the vCenter target in Intersight. Keep in mind that this does not have to be the DNS name of vCenter, but rather the name in the Intersight Targets."
}

variable "vcenter_cluster" {
  type    = string
  description = "The name of the vCenter cluster in which the Kubernetes Nodes will be provisioned."
}

variable "vcenter_datastore" {
  type    = string
  description = "The name of the vCenter datastore which will be used for storing the data of the Kubernetes Nodes/VMs."
}

variable "vcenter_network" {
  type    = list
  description = "The name of the vCenter networks which the Kubernetes Nodes/VMs will be attached to."
}

variable "vcenter_passphrase" {
  type    = string
  description = "The admin password of the ESXi hosts in the cluster."
}

variable "vcenter_target" {
  type        = string
  description = "The name of the Intersight IP pool that is used for reserving IP addresses for all cluster Nodes/VMs."
}

variable "master_count" {
  type    = number
  default = 3
  description = "The amount of Kubernetes Master Nodes/VMs to be provisioned. Can be 1 (No HA) or 3 (HA enabled)."
}

variable "worker_count" {
  type    = number
  default = 4
  description = "The amount of Kubernetes Worker Nodes/VMs to be provisioned. This has to be a value larger than 0."
}
