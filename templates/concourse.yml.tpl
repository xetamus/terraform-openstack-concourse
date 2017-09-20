---
name: concourse

releases:
- name: concourse
  version: latest
- name: garden-runc
  version: latest

stemcells:
- alias: trusty
  os: ubuntu-trusty
  version: latest

instance_groups:
- name: web
  instances: ${web_instances}
  # replace with a VM type from your BOSH Director's cloud config
  vm_type: ${web_vm_type}
  stemcell: trusty
  azs: [${az}]
  networks:
    - name: default
      default: [dns, gateway]
    - name: vip
      static_ips: [${concourse_ip}]
  jobs:
  - name: atc
    release: concourse
    properties:
      external_url: http://${concourse_ip}

      basic_auth_username: ${concourse_username}
      basic_auth_password: ${concourse_password}

      postgresql_database: &atc_db atc
  - name: tsa
    release: concourse
    properties: {}

- name: db
  instances: 1
  vm_type: ${db_vm_type}
  stemcell: trusty
  # replace with a disk type from your BOSH Director's cloud config
  persistent_disk_type: ${db_disk_type}
  azs: [${az}]
  networks: [{name: default}]
  jobs:
  - name: postgresql
    release: concourse
    properties:
      databases:
      - name: *atc_db
        # make up a role and password
        role: ${db_role}
        password: ${db_password}

- name: worker
  instances: ${worker_instances}
  # replace with a VM type from your BOSH Director's cloud config
  vm_type: ${worker_vm_type}
  stemcell: trusty
  azs: [${az}]
  networks: [{name: default}]
  jobs:
  - name: groundcrew
    release: concourse
    properties: {}
  - name: baggageclaim
    release: concourse
    properties: {}
  - name: garden
    release: garden-runc
    properties:
      garden:
        listen_network: tcp
        listen_address: 0.0.0.0:7777

update:
  canaries: 1
  max_in_flight: 1
  serial: false
  canary_watch_time: 1000-60000
  update_watch_time: 1000-60000
