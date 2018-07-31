#!/bin/bash
#
# This script copies the project files to a temporary directory so that running
# the tests does not inadvertently overwrite any of the original files.
#

SRC="$1"
DST="$2"

echo "Copying CS261 files ..."

files="$(ls $SRC)"
if [ -z "$files" ]; then
    echo "ERROR: There are no files in the project directory"
    echo "Don't forget to include '-v\$(pwd):$SRC' when running Docker"
    exit
fi

mkdir -p $DST
cp -r $SRC/* "$DST/"

echo "Done."

