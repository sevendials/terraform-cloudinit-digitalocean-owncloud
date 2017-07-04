packages:
  - mariadb-server
write_files:
  - path: /etc/my.cnf.d/terraform_override.cnf
    content: |
      [mysqld]
      bind-address = 127.0.0.1
runcmd:
  - systemctl enable mariadb
  - systemctl start mariadb
  - sleep 5
  - mysqladmin create ${db_name}
  - mysqladmin password '${db_admin_pass}'
  - mysql -p'${db_admin_pass}' -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';"
