#!/bin/sh

usage() {
  echo "Usage: $0 -p PACKAGE -v VERSION -r RELEASE"
  echo
  echo "  -p PACKAGE"
  echo "    The name of the package, like \"apache-tomcat\"."
  echo "  -v VERSION"
  echo "    The version of the package, like \"7.0.65\"."
  echo "  -r RELEASE"
  echo "    The release of the package, like \"1\"."
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
}

main() {
  if [ -d /data ] ; then
    cd /data
    mkdir -p rpmbuild/{RPMS,BUILD,SOURCES}
  else
    echo "Directory /data does not exit."
    echo
    exit 1
  fi
  if [ -f /data/${package}.spec ] ; then
    sed -i 's/Version: .*/Version: '${version}'/' /data/${package}.spec
    sed -i 's/Release: .*/Release: '${release}'/' /data/${package}.spec
  else
    echo "The file /data/${package}.spec does not exist."
    echo
    exit 3
  fi
  
  yum -y install spectool
  cd /data/rpmbuild/SOURCES/
  spectool --get-files /data/${package}.spec

  chown root:root /data/${package}.spec
  yum -y install rpmbuild
  yum -y install $(/data/scripts/buildrequires.sh /data/${package}.spec)
  cp /data/${package}.service /data/rpmbuild/SOURCES/
  rpmbuild --define "_topdir /data/rpmbuild" -bb /data/${package}.spec
}

readargs "$@"
checkargs
main
