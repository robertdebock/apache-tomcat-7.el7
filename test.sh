#!/bin/sh

yum -y localinstall /data/rpmbuild/RPMS/x86_64/apache-tomcat-7.0.65-1.x86_64.rpm

su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh start" > /dev/null && touch /var/lock/apache-tomcat

sleep 60

wget http://localhost:8080/

su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh stop" > /dev/null && rm -f /var/lock/apache-tomcat
