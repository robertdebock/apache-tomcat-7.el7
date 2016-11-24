@test "Starting Apache Tomcat." {
    /bin/su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh start"
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
    /bin/su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh stop"
    [ $status -eq 0 ]
}
