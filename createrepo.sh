#!/bin/sh

yum -y install createrepo
mkdir /data/repository/
cp /data/rpmbuild/RPMS/x86_64/* /data/repository/
cp /data/rpmbuild/RPMS/noarch/* /data/repository/
cd /data/repository/
createrepo .
echo << EOF >> index.html
<!DOCTYPE html>
<html>
<title>RPM index</title>
<body>
EOF
 
ls *.rpm | while read rpm ; do
 echo "<a href=/${rpm}>${rpm}</a>" >> index.html
done

cat << EOF >> index.html
 </body>
</html> 
EOF
