#!/usr/bin/env bats

@test "Installation test" {
    run rpm -Uvh ${DIR}/${PACKAGE}-${VERSION}-${RELEASE}.${DIST}.rpm
    [ $status -eq 0 ]
}
