#!/bin/sh

usage() {
  echo "Usage: $0 -S SOURCEDIRECTORY -d DESTINATIONDIRECTORY -k S3KEY -s S3SECRET"
  echo
  echo "  -s SOURCEDIRECTORY"
  echo "    The directory where files live."
  echo "  -d DESTINATIONDIRECTORY"
  echo "    The destination directory on S3."
  echo "  -k S3KEY"
  echo "    The Amazon key to use."
  echo "  -s S3SECRET"
  echo "    The secret for the Amazon key."
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
      -S)
        if [ "$2" ] ; then
          sourcedirectory="$2"
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
          destinationdirectory="$2"
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
  if [ ! "${sourcedirectory}" ] ; then
    echo "Missing source directory."
    echo
    usage
  fi

  if [ ! "${s3key}" ] ; then
    echo "Missing Amazon S3 Key."
    echo
    usage
  fi
  if [ ! "${s3secret}" ] ; then
    echo "Missing Amazon S3 Secret."
    echo
    usage
  fi
}

setargs() {
  if [ ! "${destinationdirectory}" ] ; then
    destinationdirectory="${sourcedirectory}"
  fi
}

publish() {
  yum -y install openssl
  for file in $(ls $sourcedirectory) ; do
    bucket=apache-tomcat7.el7 
    region=eu-west-1
    resource="/${bucket}/${destinationdirectory}/${file}"
    contentType="application/x-compressed-tar"
    dateValue=`date -R`
    stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
    # These variables are stored in Travis.
    s3Key=${s3key}
    s3Secret=${s3secret}
    signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
    echo "Sending ${sourcedirectory}/${file} to Amazon S3 (${destinationdirectory})"
    curl -k -X PUT -T "${sourcedirectory}/${file}" \
      -H "Host: ${bucket}.s3.amazonaws.com" \
      -H "Date: ${dateValue}" \
      -H "Content-Type: ${contentType}" \
      -H "Authorization: AWS ${s3Key}:${signature}" \
      https://${bucket}.s3-${region}.amazonaws.com/${destinationdirectory}/${file}
    echo "Done."
  done
}

readargs "$@"
checkargs 
publish
