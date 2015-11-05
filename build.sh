#!/bin/sh

usage() {
  echo "Usage: $0 -d DIRECTORY -s SPECFILE -v VERSION"
  echo
  echo "  -d DIRECTORY"
  echo "    Directory where the SPECfile exists."
  echo "  -s SPECFILE"
  echo "    The name of the RPM SPEC file."
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
      -d)
        if [ "$2" ] ; then
          directory="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -s)
        if [ "$2" ] ; then
          specfile="$2"
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
  if [ ! "${directory}" ] ; then
    echo "Missing directory."
    echo
    usage
  fi
 if [ ! "${specfile}" ] ; then
    echo "Missing specfile."
    echo
    usage
  fi
}

setargs() {
  :
}

checkvalues() {
  if [ ! -d "${directory}" ] ; then
   echo "$directory is not a directory."
   usage
  fi
  if [ ! -f "${directory}/${specfile}" ] ; then
   echo "$specfile is not a directory."
   usage
  fi
}

buildrpm() {
  chown root:root ${directory}/${specfile}
  yum -y groupinstall "Development Tools"
  yum -y install  ant java-1.6.0-openjdk java-1.6.0-openjdk-devel
  cp ${directory}/apache-tomcat.service ${directory}/rpmbuild/SOURCES/
  rpmbuild --define "_topdir ${directory}/rpmbuild" -ba ${directory}/${specfile}
}

readargs "$@"
checkargs
setargs
checkvalues
buildrpm
