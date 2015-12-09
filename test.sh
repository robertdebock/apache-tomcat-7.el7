#!/bin/sh

usage() {
  echo "Usage: $0 -d DIRECTORY -s SPECFILE -v VERSION"
  echo
  echo "  -p PACKAGE"
  echo "    The name of the package, like \"apache-tomcat\"."
  echo "  -v VERSION"
  echo "    The version of the package, like \"7.0.65\"."
  echo "  -r RELEASE"
  echo "    The release of the package, like \"1\"."
  echo "  -d DIST"
  echo "    The distribution tag of the package, like \"el7\"."
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
      -p)
        if [ "$2" ] ; then
          package="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -v)
        if [ "$2" ] ; then
          version="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -r)
        if [ "$2" ] ; then
          release="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -d)
        if [ "$2" ] ; then
          dist="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      *)
        echo "Unknown option or argument $1."
        echo
        shift
        usage
      ;;
    esac
  done
}

checkargs() {
  if [ ! "${package}" ] ; then
    echo "Missing package."
    echo
    usage
  fi
 if [ ! "${version}" ] ; then
    echo "Missing version."
    echo
    usage
  fi
  if [ ! "${release}" ] ; then
    echo "Missing release."
    echo
    usage
  fi
  if [ ! "${dist}" ] ; then
    echo "Missing dist."
    echo
    usage
  fi
}

main() {
  if [ -f /data/rpmbuild/RPMS/x86_64/${package}-${version}-${release}.${dist}.x86_64.rpm ] ; then
    yum -y localinstall /data/rpmbuild/RPMS/x86_64/${package}-${version}-${release}.${dist}.x86_64.rpm
    su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh start"
    sleep 10
    curl http://localhost:8080/
    su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh stop"
  else
    echo "Package /data/rpmbuild/RPMS/x86_64/${package}-${version}-${release}.${dist}.x86_64.rpm not found."
    echo
    exit 1
  fi
}

readargs "$@"
checkargs
main
