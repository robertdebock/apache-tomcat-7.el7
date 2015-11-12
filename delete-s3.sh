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
          AWS_DEFAULT_REGION="$2"
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
          AWS_ACCESS_KEY_ID="$2"
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
          AWS_SECRET_ACCESS_KEY="$2"
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
  if [ ! "${AWS_DEFAULT_REGION}" ] ; then
    echo "Missing AWS_DEFAULT_REGION."
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
  if [ ! "${AWS_ACCESS_KEY_ID}" ] ; then
    echo "Missing Amazon S3 Key."
    echo
    usage
  fi
  if [ ! "${AWS_SECRET_ACCESS_KEY}" ] ; then
    echo "Missing Amazon S3 Secret."
    echo
    usage
  fi
}

delete() {
  #yum -y install openssl
  yum -y install epel-release
  yum -y install python-pip
  pip install awscli
  aws s3 ls s3://${bucket} 
  
#  resource="/${bucket}/${file}"
#  dateValue=$(date -R)
#  stringToSign="DELETE\n\n\n${dateValue}\n${resource}"
  # These variables are stored in Travis.
#  s3Key=${AWS_ACCESS_KEY_ID}
#  s3Secret=${AWS_SECRET_ACCESS_KEY}
#  signature=$(echo -en "${stringToSign}" | openssl sha1 -hmac ${AWS_SECRET_ACCESS_KEY} -binary | base64)
#  echo "Deleting https://${bucket}.s3.amazonaws.com/${file}..."
#  echo << EOF >> headers.txt
#DELETE ${resource} HTTP/1.1
#Host: ${bucket}.s3.amazonaws.com
#Date: ${dateValue}
#Authorization: AWS ${AWS_ACCESS_KEY_ID}:${signature}
#Content-Type: text/plain
#EOF
#  curl -v -k -X DELETE -H "$(cat headers.txt)" https://${bucket}.s3.amazonaws.com
  
  #curl -k -X DELETE \
  #  -H "DELETE ${resource} HTTP/1.1" \
  #  -H "Host: ${bucket}.s3.amazonaws.com" \
  #  -H "Date: ${dateValue}" \
  #  -H "Authorization: AWS ${AWS_ACCESS_KEY_ID}:${signature}" \
  #  -H "Content-Type: text/plain" \
  #  https://${bucket}.s3.amazonaws.com
}

readargs "$@"
checkargs 
delete
