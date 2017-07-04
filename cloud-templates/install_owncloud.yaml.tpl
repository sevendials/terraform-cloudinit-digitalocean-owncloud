#cloud-config
bootcmd:
  - yum -y install epel-release
  - curl http://download.owncloud.org/download/repositories/stable/CentOS_7/ce:stable.repo -o /etc/yum.repos.d/owncloud.repo
packages:
  - python2-certbot-apache
  - httpd
  - owncloud-files
  - php
  - php-gd
  - php-mbstring
  - php-mysql
  - php-xml
write_files:
  - path: /etc/httpd/conf.d/owncloud.conf
    content: |
      <VirtualHost *:80>
        DocumentRoot "/var/www/html/owncloud"
        <Directory "/var/www/html/owncloud">
          Options Indexes FollowSymLinks MultiViews
          AllowOverride All
          Require all granted
          Dav Off
        </Directory>
        ErrorLog "/var/log/httpd/owncloud-http_error.log"
        ServerSignature Off
        CustomLog "/var/log/httpd/owncloud-http_access.log" combined
      </VirtualHost>
  - path: /var/www/html/owncloud/config/autoconfig.php
    content: |
      <?php
       $AUTOCONFIG = array(
        "dbtype" => "mysql",
        "dbname" => "${db_name}",
        "dbuser" => "${db_user}",
        "dbpass" => "${db_pass}",
        "dbhost" => "localhost",
        "dbtableprefix" => "",
        "directory" => "/var/www/html/owncloud/data",
      );
runcmd:
  - systemctl enable httpd
  - systemctl start httpd
