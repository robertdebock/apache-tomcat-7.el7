#!/bin/sh

usage() {
  echo "Usage: $0 -d DIR -p PACKAGE -v VERSION -r RELEASE"
  echo
  echo "  -d DIR"
  echo "    The name where the package can be found, like \"/data\"."
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
      -d)
        if [ "$2" ] ; then
          dir="$2"
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

installbats() {
  yum -y install epel-release
  yum -y install bats
}

readargs "$@"
checkargs
installbats

export dir package version release
find ${dir} -name '*.rpm'
yum -y localinstall ${dir}/rpmbuild/RPMS/x86_64/${package}-${version}-${release}.x86_64.rpm
yum -y localinstall ${dir}/rpmbuild/RPMS/x86_64/${package}-debuginfo-${version}-${release}.x86_64.rpm
yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-ROOT-${version}-${release}.noarch.rpm
yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-manager-${version}-${release}.noarch.rpm
yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-examples-${version}-${release}.noarch.rpm
yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-docs-${version}-${release}.noarch.rpm
yum -y localinstall ${dir}/rpmbuild/RPMS/noarch/${package}-host-manager-${version}-${release}.noarch.rpm

#bats /data/tests
