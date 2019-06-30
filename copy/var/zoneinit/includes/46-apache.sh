#!/usr/bin/env bash

# Setup hostname
sed -i "s:HOSTNAME:$(hostname):g" /opt/local/etc/httpd/vhosts/00-default.conf
svcadm enable -r svc:/pkgsrc/apache:default
svcadm enable -r svc:/pkgsrc/nagios:default
