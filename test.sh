#!/bin/sh

yum -y localinstall /data/rpmbuild/RPMS/x86_64/*.rpm
yum -y localinstall /data/rpmbuild/RPMS/noarch/*.rpm

systemctl start apache-tomcat.service
