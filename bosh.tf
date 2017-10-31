module "bosh-director" {
  source = "github.com/xetamus/terraform-openstack-bosh"

  resource_count = "${var.deploy_director ? 1 : 0}"

  os_auth_url = "${var.os_auth_url}"
  os_username = "${var.os_username}"
  os_password = "${var.os_password}"
  os_domain_name = "${var.os_domain_name}"
  os_tenant = "${var.os_tenant}"
  os_region = "${var.os_region}"

  prefix = "${var.prefix}"
  external_network = "${var.external_network}"
  external_network_uuid = "${var.external_network_uuid}"

  cidr = "${var.cidr}"
  gateway = "${var.gateway}"
  internal_ip = "${var.internal_ip}"
  reserved_ranges = "${var.reserved_ranges}"
  dns = "${var.dns}"

  image = "${var.image}"
  flavor = "${var.flavor}"
  ssh_pubkey = "${var.ssh_pubkey}"
  ssh_privkey = "${var.ssh_privkey}"

  bosh_cli_version = "${var.bosh_cli_version}"

  bosh_az = "${var.bosh_az}"
  director_ip = "${var.director_ip}"
  director_name = "${var.director_name}"
}
