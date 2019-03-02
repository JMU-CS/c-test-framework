#!/bin/bash

# extract executable name from Makefile
EXE=$(grep "EXE=" Makefile | sed -e "s/EXE=//")

# detect timeout utility (i.e., "timeout" on Linux and "gtimeout" on MacOS)
# and set timeout interval
TIMEOUT="timeout"
TIMEOUT_INTERVAL="10s"
$TIMEOUT --help &>/dev/null
if [[ $? -ne 0 ]]; then
    TIMEOUT="gtimeout"
fi

function run_test {

    # parameters
    TAG=$1
    ARGS=$2
    PTAG=$(printf '%-30s' "$TAG")

    # file paths
    OUTPUT=outputs/$TAG.txt
    DIFF=outputs/$TAG.diff
    EXPECT=expected/$TAG.txt
    VALGRND=valgrind/$TAG.txt

    # run test with timeout
    $TIMEOUT $TIMEOUT_INTERVAL $EXE $ARGS 2>/dev/null >"$OUTPUT"
    if [ "$?" -lt 124 ]; then

        # no timeout; compare output to the expected version
        diff -u "$OUTPUT" "$EXPECT" >"$DIFF"
        if [ -s "$DIFF" ]; then

            # try alternative solution (if it exists)
            EXPECT=expected/$TAG-2.txt
            if [ -e "$EXPECT" ]; then
                diff -u "$OUTPUT" "$EXPECT" >"$DIFF"
                if [ -s "$DIFF" ]; then
                    echo "$PTAG FAIL (see $DIFF for details)"
                else
                    echo "$PTAG pass"
                fi
            else
                echo "$PTAG FAIL (see $DIFF for details)"
            fi
        else
            echo "$PTAG pass"
        fi

        # run valgrind
        valgrind $EXE $ARGS &>$VALGRND
    else
        echo "$PTAG FAIL (timeout)"
    fi
}

# initialize output folders
mkdir -p outputs
mkdir -p valgrind
rm -f outputs/* valgrind/*

# run individual tests
source itests.include

# check for memory leaks
LEAK=`cat valgrind/*.txt | grep 'definitely lost' | grep -v ' 0 bytes in 0 blocks'`
if [ -z "$LEAK" ]; then
    echo "No memory leak found."
else
    echo "Memory leak(s) found. See files listed below for details."
    grep 'definitely lost' valgrind/*.txt | sed -e 's/:.*$//g' | sed -e 's/^/  - /g'
fi

