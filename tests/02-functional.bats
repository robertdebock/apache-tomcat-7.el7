@test "Checking for the apache-tomcat user." {
    getent passwd apache-tomcat
    [ $status -eq 0 ]
}

@test "Checking for the apache-tomcat group." {
    getent group apache-tomcat
    [ $status -eq 0 ]
}

@test "Starting Apache Tomcat." {
    /opt/apache-tomcat/bin/catalina.sh start
    [ $status -eq 0 ]
}

@test "Testing if port 8080 is open." {
    curl http://localhost:8080/
    [ $status -eq 0 ]
}

@test "Testing if context host-manager is available." {
    curl http://localhost:8080/host-manager/
    [ $status -eq 0 ]
}

@test "Stopping Apache Tomcat." {
    /opt/apache-tomcat/bin/catalina.sh stop
    [ $status -eq 0 ]
}
