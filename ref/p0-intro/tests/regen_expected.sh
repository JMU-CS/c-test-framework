#!/bin/bash

EXE="../intro"

function run_test {

    # parameters
    TAG=$1
    ARGS=$2

    # file paths
    EXPECT=expected/$TAG.txt

    # run test
    $EXE $ARGS 2>/dev/null >"$EXPECT"
}

# initialize output folders
mkdir -p expected
rm -f expected/*

# run individual tests
source itests.include

