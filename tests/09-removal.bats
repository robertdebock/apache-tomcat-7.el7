#!/usr/bin/env bats

@test "Checking if ${package}-debuginfo is installed." {
    run rpm -q ${package}-debuginfo
    [ $status -eq 0 ]
}

@test "Removing ${package}-debuginfo." {
    run rpm -e ${package}-debuginfo
    [ $status -eq 0 ]
}

@test "Checking if ${package}-debuginfo is removed." {
    run rpm -q ${package}-debuginfo
    [ $status -ne 0 ]
}

@test "Checking if ${package}-host-manager is installed." {
    run rpm -q ${package}-host-manager
    [ $status -eq 0 ]
}

@test "Removing ${package}-host-manager." {
    run rpm -e ${package}-host-manager
    [ $status -eq 0 ]
}

@test "Checking if ${package}-host-manager is removed." {
    run rpm -q ${package}-host-manager
    [ $status -ne 0 ]
}

@test "Checking if ${package}-examples is installed." {
    run rpm -q ${package}-examples
    [ $status -eq 0 ]
}

@test "Removing ${package}-examples." {
    run rpm -e ${package}-examples
    [ $status -eq 0 ]
}

@test "Checking if ${package}-examples is removed." {
    run rpm -q ${package}-examples
    [ $status -ne 0 ]
}

@test "Checking if ${package}-docs is installed." {
    run rpm -q ${package}-docs
    [ $status -eq 0 ]
}

@test "Removing ${package}-docs." {
    run rpm -e ${package}-docs
    [ $status -eq 0 ]
}

@test "Checking if ${package}-docs is removed." {
    run rpm -q ${package}-docs
    [ $status -ne 0 ]
}

@test "Checking if ${package}-ROOT is installed." {
    run rpm -q ${package}-ROOT
    [ $status -eq 0 ]
}

@test "Removing ${package}-ROOT." {
    run rpm -e ${package}-ROOT
    [ $status -eq 0 ]
}

@test "Checking if ${package}-ROOT is removed." {
    run rpm -q ${package}-ROOT
    [ $status -ne 0 ]
}

@test "Checking if ${package}-manager is installed." {
    run rpm -q ${package}-manager
    [ $status -eq 0 ]
}

@test "Removing ${package}-manager." {
    run rpm -e ${package}-manager
    [ $status -eq 0 ]
}

@test "Checking if ${package}-manager is removed." {
    run rpm -q ${package}-manager
    [ $status -ne 0 ]
}

@test "Checking if ${package} is installed." {
    run rpm -q ${package}
    [ $status -eq 0 ]
}

@test "Removing ${package}." {
    run rpm -e ${package}
    [ $status -eq 0 ]
}

@test "Checking if ${package} is removed." {
    run rpm -q ${package}
    [ $status -ne 0 ]
}
