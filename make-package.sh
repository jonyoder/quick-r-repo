#!/bin/bash

function cleanup () {
  rm ${description}
  rm -r ${pkgdir}
  rm -r ${outputdir}

  code=$?
  if [[ ${code} -gt 0 ]]; then
    cp ${backup} public/src/contrib/PACKAGES
  fi
  exit $code
}

trap cleanup INT TERM EXIT

# Back up the PACKAGES file
backup=`mktemp`
cat public/src/contrib/PACKAGES > ${backup}

# Make a description file
description=`mktemp`
echo "First, edit and save the description file. Press ENTER to continue..."
read
cat DESCRIPTION_TEMPLATE > ${description}
vim ${description}

# Make a package
pkgdir=`mktemp -d`
outputdir=`mktemp -d`
cp ${description} ${pkgdir}/DESCRIPTION
mkdir ${pkgdir}/R
cp R_TEMPLATE ${pkgdir}/R/hello.R

# Capture special path
special=`cat ${description} | grep "Path:" | cut -f2 -d ':' | xargs`
echo "special dir: ${special}"

# Build the package
R -e "devtools::build(pkg=\"${pkgdir}\", path=\"${outputdir}\")"
code=$?
if [[ $code -gt 0 ]]; then
  exit $code
fi
mkdir -p ./public/src/contrib/${special}
cp ${outputdir}/*.tar.gz public/src/contrib/${special}/

# Append to the PACKAGES file
echo "" >> public/src/contrib/PACKAGES
cat ${description} | grep "Package:\|Version:\|Path:\|Depends:\|Imports:\|Suggests\:LinkingTo:" >> public/src/contrib/PACKAGES

