@test "Starting Apache Tomcat." {
    service apache-tomcat start
    [ $status -eq 0 ]
}

@test "Testing if port 8080 is open." {
    curl http://localhost:8080
    [ $status -eq 0 ]
}

@test "Testing if context host-manager is available." {
    curl http://localhost:8080/host-manager
    [ $status -eq 0 ]
}

@test "Stopping Apache Tomcat." {
    service apache-tomcat stop
    [ $status -eq 0 ]
}
