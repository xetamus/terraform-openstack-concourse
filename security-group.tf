resource "openstack_networking_secgroup_rule_v2" "concourse-http" {
  security_group_id = "${var.deploy_director ? module.bosh-director.secgroup_id : var.secgroup_id}"
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 8080
  port_range_max = 8080
  remote_ip_prefix = "0.0.0.0/0"
}
