#!/bin/sh

usage() {
  echo "Usage: $0 -r REGION -b BUCKET -d DIRECTORY -k S3KEY -s S3SECRET"
  echo
  echo "  -r REGION"
  echo "    The Amazon S3 Region, i.e. eu-west-1"
  echo "  -b BUCKET"
  echo "    The Amazon S3 Bucket to work in."
  echo "  -d DIRECTORY"
  echo "    The local directory to sync."
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
          export AWS_DEFAULT_REGION="$2"
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
      -k)
        if [ "$2" ] ; then
          export AWS_ACCESS_KEY_ID="$2"
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
          export AWS_SECRET_ACCESS_KEY="$2"
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
  if [ ! "${directory}" ] ; then
    echo "Missing directory."
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
  yum -y install epel-release
  yum -y install python-pip
  pip install awscli
  aws s3 rm s3://${bucket}/repodata/ --recursive
  aws s3 sync ${directory} s3://${bucket}
}

readargs "$@"
checkargs 
delete
