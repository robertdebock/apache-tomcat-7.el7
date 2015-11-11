#!/bin/sh

usage() {
  echo "Usage: $0 -r REGION -b BUCKET -f FILE -k S3KEY -s S3SECRET"
  echo
  echo "  -r REGION"
  echo "    The Amazon S3 Region, i.e. eu-west-1"
  echo "  -b BUCKET"
  echo "    The Amazon S3 Bucket to work in."
  echo "  -f FILE"
  echo "    The file to delete, including a path in S3, without a starting /."
  echo "    i.e. photos/puppy.jpg"
  echo "  -k S3KEY"
  echo "    The Amazon key to use."
  echo "  -s S3SECRET"
  echo "    The secret for the Amazon key."
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
      -r)
        if [ "$2" ] ; then
          region="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -b)
        if [ "$2" ] ; then
          bucket="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -f)
        if [ "$2" ] ; then
          file="$2"
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
  if [ ! "${region}" ] ; then
    echo "Missing region."
    echo
    usage
  fi
  if [ ! "${bucket}" ] ; then
    echo "Missing bucket."
    echo
    usage
  fi
  if [ ! "${file}" ] ; then
    echo "Missing file."
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

delete() {
  yum -y install openssl
  resource="/${bucket}/${file}"
  dateValue=$(date -R)
  stringToSign="DELETE\n\n\n${dateValue}\n${resource}"
  # These variables are stored in Travis.
  s3Key=${s3key}
  s3Secret=${s3secret}
  signature=$(echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64)
  echo "Deleting https://${bucket}.s3.amazonaws.com/${file}..."
  curl -k -X POST \
    -H "DELETE ${resource} HTTP/1.1" \
    -H "Host: s3.amazonaws.com" \
    -H "Date: ${dateValue}" \
    -H "Authorization: AWS ${s3Key}:${signature}" \
    https://${bucket}.s3.amazonaws.com/
}

readargs "$@"
checkargs 
delete
