#!/bin/sh

yum -y localinstall /data/rpmbuild/RPMS/x86_64/apache-tomcat-?.*.x86_64.rpm
su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh start"
sleep 10
su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh stop"
