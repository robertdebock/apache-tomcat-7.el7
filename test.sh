#!/bin/sh

yum -y localinstall /data/rpmbuild/RPMS/{x86_64,noarch}/*.rpm

systemctl start apache-tomcat.service
