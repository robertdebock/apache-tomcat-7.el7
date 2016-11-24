#!/usr/bin/env bats

@test "Installing ${package}." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/x86_64/${package}-${version}-${release}.x86_64.rpm
    [ $status -eq 0 ]
}

@test "Testing if ${package} is installed." {
    run rpm -q ${package}
    [ $status -eq 0 ]
}

@test "Installing ${package}-debuginfo." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/x86_64/${package}-debuginfo-${version}-${release}.x86_64.rpm
    [ $status -eq 0 ]
}

@test "Testing if ${package}-debuginfo is installed." {
    run rpm -q ${package}-debuginfo
    [ $status -eq 0 ]
}

@test "Installing ${package}-manager." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-manager-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing if ${package}-manager is installed." {
    run rpm -q ${package}-manager
    [ $status -eq 0 ]
}

@test "Installing of ${package}-ROOT." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-ROOT-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing if ${package}-ROOT is installed." {
    run rpm -q ${package}-ROOT
    [ $status -eq 0 ]
}

@test "Installing of ${package}-docs." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-docs-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing if ${package}-docs is installed." {
    run rpm -q ${package}-docs
    [ $status -eq 0 ]
}

@test "Installing of ${package}-examples." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-examples-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing if ${package}-examples is installed." {
    run rpm -q ${package}-examples
    [ $status -eq 0 ]
}

@test "Installing of ${package}-host-manager." {
    run yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-host-manager-${version}-${release}.noarch.rpm
    [ $status -eq 0 ]
}

@test "Testing if ${package}-host-manager is installed." {
    run rpm -q ${package}-host-manager
    [ $status -eq 0 ]
}
