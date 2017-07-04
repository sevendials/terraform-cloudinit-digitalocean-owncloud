data "template_file" "install_mariadb_database" {
  template = "${file("cloud-templates/install_mariadb_database.yaml.tpl")}"

  vars {
    db_admin_pass = "${var.db_admin_pass}"
    db_name = "${var.db_name}"
    db_user = "${var.db_user}"
    db_pass = "${var.db_pass}"
  }
}

data "template_file" "install_owncloud" {
  template = "${file("cloud-templates/install_owncloud.yaml.tpl")}"

  vars {
    db_name = "${var.db_name}"
    db_user = "${var.db_user}"
    db_pass = "${var.db_pass}"
  }
}

# Render a multi-part cloudinit config making use of the part
# above, and other source files
data "template_cloudinit_config" "owncloud" {
  base64_encode = false
  gzip          = false
  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.install_mariadb_database.rendered}"
    merge_type = "list(append)+dict(recurse_array)+str()"
  }

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.install_owncloud.rendered}"
    merge_type = "list(append)+dict(recurse_array)+str()"
  }

}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "owncloud" {
  name      = "${var.do_droplet_name}"
  size      = "${var.do_droplet_size}"
  region    = "${var.do_droplet_region}"
  image     = "centos-7-0-x64"
  ssh_keys  = ["${var.do_ssh_key}"]
  user_data = "${data.template_cloudinit_config.owncloud.rendered}"
}
