#!/usr/bin/env bats

@test "Testing the removal of ${package}-debuginfo." {
    run rpm -e ${package}-debuginfo
    [ $status -eq 0 ]
}

@test "Testing the removal of ${package}-host-manager." {
    run rpm -e ${package}-host-manager
    [ $status -eq 0 ]
}

@test "Testing the removal of ${package}-examples." {
    run rpm -e ${package}-examples
    [ $status -eq 0 ]
}

@test "Testing the removal of ${package}-docs." {
    run rpm -e ${package}-docs
    [ $status -eq 0 ]
}

@test "Testing the removal of ${package}-ROOT." {
    run rpm -e ${package}-ROOT
    [ $status -eq 0 ]
}

@test "Testing the removal of ${package}-manager." {
    run rpm -e ${package}-manager
    [ $status -eq 0 ]
}

@test "Testing the removal of ${package}." {
    run rpm -e ${package}
    [ $status -eq 0 ]
}
