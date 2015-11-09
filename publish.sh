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

gemfury() {
  curl -F package=@${package} ${url}
}

s3() {
  yum -y install openssl
  file=/data/rpmbuild/RPMS/x86_64/${package} 
  bucket=apache-tomcat7.el7 
  region=eu-west-1
  resource="/${bucket}/${file}"
  contentType="application/x-compressed-tar"
  dateValue=`date -R`
  stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
  # These variables are stored in Travis.
  s3Key=${s3key}
  s3Secret=${secret}
  signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
  curl -X PUT -T "${file}" \
    -H "Host: ${bucket}.s3.amazonaws.com" \
    -H "Date: ${dateValue}" \
    -H "Content-Type: ${contentType}" \
    -H "Authorization: AWS ${s3Key}:${signature}" \
    https://${bucket}.s3-${region}.amazonaws.com/${file}
}

readargs "$@"
checkargs 
setargs 
checkvalues 
gemfury
s3
