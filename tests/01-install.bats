#!/usr/bin/env bats

@test "Testing the installation of ${package}-${version}-${release}.${dist}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${package}-${version}-${release}.${dist}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-manager-${version}-${release}.${dist}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${package}-manager-${version}-${release}.${dist}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-ROOT-${version}-${release}.${dist}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${package}-ROOT-${version}-${release}.${dist}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-docs-${version}-${release}.${dist}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${package}-docs-${version}-${release}.${dist}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-examples-${version}-${release}.${dist}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${package}-examples-${version}-${release}.${dist}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-tomcat-host-manager-${version}-${release}.${dist}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${package}-tomcat-host-manager-${version}-${release}.${dist}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${package}-tomcat-debuginfo-${version}-${release}.${dist}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${package}-debuginfo-${version}-${release}.${dist}.rpm
    [ $status -eq 0 ]
}
