data "template_file" "concourse-manifest" {
  template = "${file("templates/concourse.yml.tpl")}"

  vars {
    az = "${var.bosh_az}"
    web_instances = "${var.concourse_web_instances}"
    web_vm_type = "${var.concourse_web_vm_type}"
    concourse_ip = "${openstack_compute_floatingip_v2.concourse-web.address}"
    concourse_username = "${var.concourse_username}"
    concourse_password = "${var.concourse_password}"
    db_vm_type = "${var.concourse_db_vm_type}"
    db_disk_type = "${var.concourse_db_disk_type}"
    db_role = "${var.concourse_db_username}"
    db_password = "${var.concourse_db_password}"
    worker_instances = "${var.concourse_worker_instances}"
    worker_vm_type = "${var.concourse_worker_vm_type}"
    network = "${module.bosh-director.bosh-network-name}"
  }
}

resource "openstack_compute_floatingip_v2" "concourse-web" {
  pool = "${var.external_network}"
}

resource "null_resource" "deploy-concourse" {
  triggers {
    bosh-director = "${module.bosh-director.deploy-bosh-id}"
  }

  connection {
    type = "ssh"
    host = "${module.bosh-director.jumpbox-floating-ip}"
    user = "ubuntu"
    private_key = "${chomp(file("${var.ssh_privkey}"))}"
  }

  provisioner "file" {
    content = "${data.template_file.concourse-manifest.rendered}"
    destination = "~/concourse.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "bosh -n -e ${var.prefix} upload-stemcell https://bosh.io/d/stemcells/bosh-openstack-kvm-ubuntu-trusty-go_agent",
      "bosh -n -e ${var.prefix} upload-release https://bosh.io/d/github.com/concourse/concourse",
      "bosh -n -e ${var.prefix} upload-release https://bosh.io/d/github.com/cloudfoundry/garden-runc-release",
      "bosh -n -e ${var.prefix} -d concourse deploy concourse.yml"
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "bosh -n -e ${var.prefix} -d concourse delete-deployment --force"
    ]
  }
}
