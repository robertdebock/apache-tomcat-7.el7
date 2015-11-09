#!/bin/sh


yum -y install createrepo
mkdir /data/repository/
cp /data/rpmbuild/RPMS/x86_64/* /data/repository/
cp /data/rpmbuild/RPMS/noarch/* /data/repository/
cd /data/repository/
createrepo .

file=/data/rpmbuild/RPMS/x86_64/apache-tomcat-7.0.65-1.el7.x86_64.rpm 
bucket=apache-tomcat7.el7 
resource="/${bucket}/${file}"
contentType="application/x-compressed-tar"
dateValue=`date -R`
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
s3Key=${s3key}
s3Secret=${secret}
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
curl -X PUT -T "${file}" \
  -H "Host: ${bucket}.s3.amazonaws.com" \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  https://${bucket}.s3.amazonaws.com/${file}
