#!/bin/sh

yum -y localinstall /data/rpmbuild/RPMS/x86_64/apache-tomcat-7.0.65-1.x86_64.rpm

su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh start"

sleep 10

netstat -tulpen | grep :8080

su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh stop"
