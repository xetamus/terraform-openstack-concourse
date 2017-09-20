resource "openstack_networking_secgroup_rule_v2" "concourse-http" {
  security_group_id = "${module.bosh-director.bosh-secgroup-id}"
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 8080
  port_range_max = 8080
  remote_ip_prefix = "0.0.0.0/0"
}
