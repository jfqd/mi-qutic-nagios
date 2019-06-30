#!/usr/bin/env bash

# Setup hostname
sed -i "s:HOSTNAME:$(hostname):g" /opt/local/etc/httpd/vhosts/00-default.conf

# create htpasswd file
if mdata-get apache_htpasswd 1>/dev/null 2>&1; then
  user=$(mdata-get apache_htpasswd | tr ":"  "\n" | sed -n 1p)
  pass=$(mdata-get apache_htpasswd | tr ":"  "\n" | sed -n 2p)
  crypt=$(openssl passwd -apr1 $pass)
  echo "$user:$crypt" > /opt/local/etc/nagios/htpasswd.users
  chown www:root /opt/local/etc/nagios/htpasswd.users
  chmod 0640 /opt/local/etc/nagios/htpasswd.users
fi

svcadm enable -r svc:/pkgsrc/apache:default
svcadm enable -r svc:/pkgsrc/nagios:default
