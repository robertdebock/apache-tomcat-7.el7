#!/bin/sh

usage() {
  echo "Usage: $0 -d directory -s SPECfile"
  echo
  echo "  -d DIRECTORY"
  echo "    Directory where the SPECfile exists."
  echo "  -s SPECfile"
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
    echo "Missing argument."
    exit 2
  fi
 if [ ! "${specfile}" ] ; then
    echo "Missing argument."
    exit 2
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
  mkdir -p ${directory}/rpmbuild/{RPMS,BUILD,SOURCES}
  wget -P ${directory}/rpmbuild/SOURCES/ http://www.eu.apache.org/dist/tomcat/tomcat-7/v7.0.65/bin/apache-tomcat-7.0.65.tar.gz
  rpmbuild --define "_topdir ${directory}/rpmbuild" -ba ${directory}/${specfile}
}

readargs "$@"
checkargs
setargs
checkvalues
buildrpm
