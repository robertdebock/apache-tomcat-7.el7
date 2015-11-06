#!/bin/sh

usage() {
  echo "Usage: $0 -u URL -p PACKAGE"
  echo
  echo "  -u URL" 
  echo "    The URL to publish to."
  echo "  -p PACKAGE"
  echo "    The package (RPM) to upload."
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
      -u)
        if [ "$2" ] ; then
          url="$2"
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
  if [ ! "${url}" ] ; then
    echo "Missing furyurl."
    echo
    usage
  fi
  if [ ! "${package}" ] ; then
    echo "Missing package."
    echo
    usage
  fi
  regex='^(?!(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|])'
  if [[ ${URL} =~ $regex ]] ; then
    echo "URL ${URL} is not a valid URL."
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
  curl -F package=@${package} ${url}
}

makerepo() {
  yum -y install createrepo
  mkdir /data/repository/
  cp /data/rpmbuild/RPMS/x86_64/* /data/repository/
  cp /data/rpmbuild/RPMS/noarch/* /data/repository/
  cd /data/repository/
  createrepo .
  ls -la
}

readargs "$@" 
checkargs 
setargs 
checkvalues 
main
makerepo
