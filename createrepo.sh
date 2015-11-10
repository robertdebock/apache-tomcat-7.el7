#!/bin/sh


yum -y install createrepo
mkdir /data/repository/
cp /data/rpmbuild/RPMS/x86_64/* /data/repository/
cp /data/rpmbuild/RPMS/noarch/* /data/repository/
cd /data/repository/
ls -la
createrepo .
ls -la
ls -la repodata/
