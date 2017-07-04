output "foo" {
  value = "${data.template_cloudinit_config.owncloud.rendered}"
}

output "address" {
  value = "${digitalocean_droplet.owncloud.ipv4_address}"
}
