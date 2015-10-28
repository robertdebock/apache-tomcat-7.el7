# apache-tomcat-rpm

[![Build Status](https://travis-ci.org/robertdebock/apache-tomcat-rpm.svg)](https://travis-ci.org/robertdebock/apache-tomcat-rpm)

This repository contains sources of [Apache Tomcat 7](http://tomcat.apache.org) RPM's for [CentOS 7](https://www.centos.org/).

[Travis-CI](https://travis-ci.org/robertdebock/apache-tomcat-rpm) is being used to build, test and publish the RPM.

The RPMs are published to [Gemfury](https://gemfury.com/robertdebock). To use these packages, add this repository:

    [fury]
    name=Robert de Bock
    baseurl=https://repo.fury.io/robertdebock/
    enabled=1
    gpgcheck=0
