variable "deploy_director" { default = true }
variable "jumpbox_ip" { default = "" }
variable "secgroup_id" { default = "" }

variable "os_auth_url" { default = "" }
variable "os_username" { default = "" }
variable "os_password" { default = "" }
variable "os_domain_name" { default = "Default" }
variable "os_tenant" { default = "" } //OS_PROJECT_NAME if v3 auth
variable "os_region" {default = "RegionOne" }
variable "prefix" {}

variable "external_network" {}
variable "external_network_uuid" {}

variable "cidr" { default = "10.0.0.0/26" }
variable "gateway" { default = "10.0.0.1" }
variable "internal_ip" { default = "10.0.0.10" }
variable "reserved_ranges" { default = "10.0.0.0-10.0.0.11" }
variable "dns" { 
  type = "list"
  default = ["8.8.8.8", "8.8.4.4"]
}

variable "image" { default = "ubuntu-xenial" }
variable "flavor" { default = "m1.medium" }
variable "ssh_pubkey" { default = "~/.ssh/id_rsa.pub" }
variable "ssh_privkey" { default ="~/.ssh/id_rsa" }

variable "bosh_cli_version" { default = " " }

variable "bosh_az" { default = "nova" }
variable "director_ip" { default = "10.0.0.11" }
variable "director_name" { default = "bosh01" }

variable "concourse_web_instances" { default = 1 }
variable "concourse_web_vm_type" { default = "small" }
variable "concourse_worker_instances" { default = 1 }
variable "concourse_worker_vm_type" { default = "large" }
variable "concourse_db_vm_type" { default = "medium" }
variable "concourse_db_disk_type" { default = "large" }
variable "concourse_db_username" { default = "concourse" }
variable "concourse_db_password" {}
variable "concourse_username" { default = "concourse" }
variable "concourse_password" {}
