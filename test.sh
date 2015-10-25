#!/bin/sh

yum -y localinstall /data/rpmbuild/RPMS/x86_64/apache-tomcat-7.0.65-1.x86_64.rpm
/etc/init.d/apache-tomcat start
