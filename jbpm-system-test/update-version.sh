#!/usr/bin/env bash

if [[ $# != 1 || $1 = -h || $1 = --help ]]
then
  echo "Usage: $0 [OPTIONS] <new_version>"
  echo ""
  echo "Updates version of this project, including parents of individual modules."
  echo ""
  echo "Example:"
  echo ""
  echo "$0 7.58.0.Final"
  echo ""
  echo "OPTIONS"
  echo " -h, --help      display this help"
  echo ""
  exit 1
fi

function replace_in_poms() {
  if [[ $1 == "$2" ]]
  then
    echo "WARNING: Old version ‘$1’ is same as new version ‘$2’. Skipping."
  else
    find . -name 'pom*.xml' -exec sed -i "s/$1/$2/" {} \;
  fi
}

NEW_VERSION="$1"
OLD_VERSION=$(grep "^    <version>" -h pom.xml | head -n1 | sed 's:[^/]*>\(.*\)</.*:\1:')

replace_in_poms "$OLD_VERSION" "$NEW_VERSION"
