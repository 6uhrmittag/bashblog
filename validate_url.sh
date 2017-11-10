#!/bin/bash
validate_url(){
url="$1"
if [ ! -z $url ]; then
##validate url
  if [[ ! -z $( curl -Is $url | head -1 | grep 200 ) ]]; then
    echo "Link ok!"
    return 0
  else
    echo "ERROR: URL not reachable"
    return 1
  fi
else
  echo "ERROR: empty URL"
  return 1
fi
}

validate_url $1
