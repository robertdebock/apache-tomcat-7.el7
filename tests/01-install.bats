#!/usr/bin/env bats

@test "Testing the installation of ${package}." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/x86_64/${package}-${version}-${release}.${dist}.x86_64.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-manager." {
    run rpm -Uvh ${dir}/rpmbuild/RPMS/noarch/${package}-manager-${version}-${release}.${dist}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Tesing if ${package}-ROOT exists." {
    run test -f ${dir}/rpmbuild/RPMS/noarch/${package}-ROOT-${version}-${release}.${dist}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-ROOT." {
    run rpm -Uvh ${dir}/rpmbuild/RPMS/noarch/${package}-ROOT-${version}-${release}.${dist}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-docs." {
    run rpm -Uvh ${dir}/rpmbuild/RPMS/noarch/${package}-docs-${version}-${release}.${dist}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-examples." {
    run rpm -Uvh ${dir}/rpmbuild/RPMS/noarch/${package}-examples-${version}-${release}.${dist}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-tomcat-host-manager." {
    run rpm -Uvh ${dir}/rpmbuild/RPMS/noarch/${package}-tomcat-host-manager-${version}-${release}.${dist}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-tomcat-debuginfo." {
    run rpm -Uvh ${dir}/rpmbuild/RPMS/x86_64/${package}-debuginfo-${version}-${release}.${dist}.x86_64.rpm
    [ $status -eq 0 ]
}
