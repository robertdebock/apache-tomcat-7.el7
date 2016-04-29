#!/bin/sh

usage() {
  echo "Usage: $0 SPECFILE"
  echo
  echo "  SPECFILE"
  echo "    The full path to the SPECFILE, like \"/data/package-1.1.spec\"."
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
   specfile="$1"
   shift
  done
}

checkargs() {
  if [ ! "${specfile}" ] ; then
    echo "Missing specfile."
    echo
    usage
  fi
}

checkvalues() {
  if [ ! -f "$specfile" ] ; then
    echo "Specfile ${specfile} does not exist."
    echo
    usage
  fi
}

printbuildrequires () {
  grep -E 'BuildRequires' ${specfile} | while read buildrequires ; do
    echo ${buildrequires} | cut -d " " -f 2-
  done | xargs
}

readargs "$@"
checkargs
checkvalues
printbuildrequires
