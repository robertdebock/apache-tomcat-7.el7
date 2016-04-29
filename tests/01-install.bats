#!/usr/bin/env bats

@test "Testing the installation of ${package}." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/x86_64/${package}-${version}-${release}.x86_64.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-manager." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-manager-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Tesing if ${package}-ROOT exists." {
    run test -f ${dir}/rpmbuild/RPMS/noarch/${package}-ROOT-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-ROOT." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-ROOT-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-docs." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-docs-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-examples." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-examples-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-tomcat-host-manager." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-tomcat-host-manager-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-tomcat-debuginfo." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/x86_64/${package}-debuginfo-${version}-${release}.x86_64.rpm
    [ $status -eq 0 ]
}
