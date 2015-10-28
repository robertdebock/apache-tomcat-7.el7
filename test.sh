#!/bin/sh

usage() {
  echo "Usage: $0 -v VERSION"
  echo
  echo "  -v VERSION" 
  echo "    The version of the package, without the release number, i.e. 7.0.65" 
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
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
  if [ ! "${version}" ] ; then
    echo "Missing version."
    usage
  fi
}

setargs() {
  :
}

checkvalues() {
 :
}

main() {
  yum -y localinstall /data/rpmbuild/RPMS/x86_64/apache-tomcat-${version}-1-el7.x86_64.rpm
  su -p -s /bin/sh apache-tomcat -c "/opt/apache-tomcat/bin/catalina.sh start"
}

readargs "$@" 
checkargs 
setargs 
checkvalues 
main 
