output "Jumpbox IP" {
  value = "${module.bosh-director.jumpbox-floating-ip}"
}

output "Jumpbox User" {
  value = "ubuntu"
}

output "Concourse URL" {
  value = "http://${openstack_compute_floatingip_v2.concourse-web.address}:8080"
}
