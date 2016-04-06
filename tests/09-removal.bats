#!/usr/bin/env bats

@test "Testing the removal of ${PACKAGE}." {
    run rpm -e ${PACKAGE}
    [ $status -eq 0 ]
}

@test "Testing the removal of ${PACKAGE}-manager." {
    run rpm -e ${PACKAGE}-manager
    [ $status -eq 0 ]
}

@test "Testing the removal of ${PACKAGE}-ROOT." {
    run rpm -e ${PACKAGE}-ROOT
    [ $status -eq 0 ]
}

@test "Testing the removal of ${PACKAGE}-docs." {
    run rpm -e ${PACKAGE}-docs
    [ $status -eq 0 ]
}

@test "Testing the removal of ${PACKAGE}-examples." {
    run rpm -e ${PACKAGE}-examples
    [ $status -eq 0 ]
}

@test "Testing the removal of ${PACKAGE}-tomcat-host-manager." {
    run rpm -e ${PACKAGE}-tomcat-host-manager
    [ $status -eq 0 ]
}

@test "Testing the removal of ${PACKAGE}-tomcat-debuginfo." {
    run rpm -e ${PACKAGE}-debuginfo
    [ $status -eq 0 ]
}
