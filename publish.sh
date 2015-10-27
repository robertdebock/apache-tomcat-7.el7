#!/bin/sh

usage() {
  echo "Usage: $0 -u FURYURL"
  echo
  echo "  -u FURYURL" 
  echo "    The URL to FURY as provided by FURY. (This includes credentials.)" 
  echo "  -p PACKAGE"
  echo "    The package (RPM) to upload."
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
      -u)
        if [ "$2" ] ; then
          furyurl="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
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
  if [ ! "${furyurl}" ] ; then
    echo "Missing furyurl."
    echo
    usage
  fi
  if [ ! "${package}" ] ; then
    echo "Missing package."
    echo
    usage
  fi
}

setargs() {
  :
}

checkvalues() {
  if [ ! -f ${package} ] ; then
    echo "Package ${package} does not exist."
    echo
    usage
  fi
}

main() {
  curl -F package=@${package} https://zPx1qa2AWzJmQGcH-L94@push.fury.io/meinitconsultancy/
}

readargs "$@" 
checkargs 
setargs 
checkvalues 
main
