variable "db_admin_pass" {
  "description" = "MariaDB root password: "
}

variable "db_name" {
  "description" = "MariaDB application name: "
  "default" = "owncloud"
}

variable "db_user" {
  "description" = "MariaDB application user: "
  "default" = "owncloud"
}

variable "db_pass" {
  "description" = "MariaDB application password: "
}

variable "do_token" {
  "description" = "DigitalOcean Token: "
}

variable "do_droplet_name" {
  "description" = "DigitalOcean Droplet Name: "
  "default" = "owncloud"
}

variable "do_droplet_region" {
  "description" = "DigitalOcean Droplet Region: "
  "default" = "nyc1"
}

variable "do_droplet_size" {
  "description" = "DigitalOcean Droplet Size: "
  "default" = "512mb"
}

variable "do_ssh_key" {
  "description" = "DigitalOcean SSH Key (fingerprint or id): "
}

