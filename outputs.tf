output "Jumpbox IP" {
  value = "${var.deploy_director ? module.bosh-director.jumpbox_ip : var.jumpbox_ip}"
}

output "Jumpbox User" {
  value = "ubuntu"
}

output "Concourse URL" {
  value = "http://${openstack_compute_floatingip_v2.concourse-web.address}:8080"
}
