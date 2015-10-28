# apache-tomcat-7-rpm

[![Build Status](https://travis-ci.org/robertdebock/apache-tomcat-7-rpm.svg?branch=master)](https://travis-ci.org/robertdebock/apache-tomcat-7-rpm)

This repository contains sources of [Apache Tomcat 7](http://tomcat.apache.org) RPM's for [CentOS 7](https://www.centos.org/).

[Travis-CI](https://travis-ci.org/robertdebock/apache-tomcat-rpm) is being used to build, test and publish the RPM.

The RPMs are published to [Gemfury](https://gemfury.com/robertdebock). To use these packages, copy this text into /etc/yum.repos.d/robertdebock.repo:

    [robertdebock]
    name=Robert de Bock
    baseurl=https://repo.fury.io/robertdebock/
    enabled=1
    gpgcheck=0

And run:

    yum install apache-tomcat
    
Optional extra packages are:
- apache-tomcat-manager
- apache-tomcat-ROOT
- apache-tomcat-docs
- apache-tomcat-examples
- apache-tomcat-host-manager
