#!/bin/sh

usage() {
  echo "Usage: $0 -u URL -p PACKAGE"
  echo
  echo "  -u URL" 
  echo "    The URL to publish to."
  echo "  -p PACKAGE"
  echo "    The package (RPM) to upload."
  echo "  -k S3KEY"
  echo "    The Amazon key to use."
  echo "  -s S3SECRET"
  echo "    The secret for the Amazon key."
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
      -k)
        if [ "$2" ] ; then
          s3key="$2"
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
          s3secret="$2"
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
  if [ ! "${s3key}" ] ; then
    echo "Missing Amazon S3 Key."
    echo
    usage
  fi
  if [ ! "${secret}" ] ; then
    echo "Missing Amazon S3 Secret."
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
  echo "Sending ${package} to GemFury..."
  curl -F package=@${package} ${url}
  echo "Done."
}

amazons3() {
  yum -y install openssl
  file=${package} 
  bucket=apache-tomcat7.el7 
  region=eu-west-1
  resource="/${bucket}/${file}"
  contentType="application/x-compressed-tar"
  dateValue=`date -R`
  stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
  # These variables are stored in Travis.
  s3Key=${s3key}
  s3Secret=${s3secret}
  signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
  echo "Sending ${package} to Amazon S3..."
  curl -k -X PUT -T "${file}" \
    -H "Host: ${bucket}.s3.amazonaws.com" \
    -H "Date: ${dateValue}" \
    -H "Content-Type: ${contentType}" \
    -H "Authorization: AWS ${s3Key}:${signature}" \
    https://${bucket}.s3-${region}.amazonaws.com/${file}
  echo "Done."
}

readargs "$@"
checkargs 
setargs 
checkvalues 
gemfury
amazons3
