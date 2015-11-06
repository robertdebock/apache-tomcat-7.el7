#!/bin/sh


yum -y install createrepo
mkdir /data/repository/
cp /data/rpmbuild/RPMS/x86_64/* /data/repository/
cp /data/rpmbuild/RPMS/noarch/* /data/repository/
cd /data/repository/
createrepo .
ls -la
