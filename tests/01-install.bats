#!/usr/bin/env bats

@test "Testing the installation of ${PACKAGE}-${VERSION}-${RELEASE}.${DIST}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${PACKAGE}-${VERSION}-${RELEASE}.${DIST}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${PACKAGE}-manager-${VERSION}-${RELEASE}.${DIST}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${PACKAGE}-manager-${VERSION}-${RELEASE}.${DIST}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${PACKAGE}-ROOT-${VERSION}-${RELEASE}.${DIST}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${PACKAGE}-ROOT-${VERSION}-${RELEASE}.${DIST}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${PACKAGE}-docs-${VERSION}-${RELEASE}.${DIST}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${PACKAGE}-docs-${VERSION}-${RELEASE}.${DIST}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${PACKAGE}-examples-${VERSION}-${RELEASE}.${DIST}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${PACKAGE}-examples-${VERSION}-${RELEASE}.${DIST}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${PACKAGE}-tomcat-host-manager-${VERSION}-${RELEASE}.${DIST}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${PACKAGE}-tomcat-host-manager-${VERSION}-${RELEASE}.${DIST}.rpm
    [ $status -eq 0 ]
}

@test "Testing the installation of ${PACKAGE}-tomcat-debuginfo-${VERSION}-${RELEASE}.${DIST}.rpm." {
    run rpm -Uvh ${DIR}/rpmbuild/RPMS/x86_64/${PACKAGE}-debuginfo-${VERSION}-${RELEASE}.${DIST}.rpm
    [ $status -eq 0 ]
}
