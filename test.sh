#!/bin/sh

yum -y localinstall /data/rpmbuild/RPMS/x86_64/*.rpm
yum -y localinstall /data/rpmbuild/RPMS/noarch/*.rpm

ls -l /etc/init.d/
echo "==="
ls -l /etc/rc.d/init.d/

/etc/init.d/apache-tomcat start
