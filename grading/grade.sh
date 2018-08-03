#!/bin/bash

source project.include

# all students
for eid in `ls $SUBMIT`; do

    echo "== $eid =="

    # clear old results
    rm -rf "$RESULTS/$eid"

    # check for submission
    if [ -e "$SUBMIT/$eid/$TAG" ]; then

        runpath="$RESULTS/$eid"

        # create testing folder for this student
        mkdir -p "$runpath"

        # check and copy all files
        ok="yes"
        for f in $FILES; do
            if [ ! -e "$SUBMIT/$eid/$TAG/$f" ]; then
                ok="no"
            else
                cp -H "$SUBMIT/$eid/$TAG/$f" "$runpath/$f"
            fi
        done

        # check for completeness
        if [ "$ok" == "yes" ]; then

            # copy other files
            for f in $REFFILES; do
                cp -rL "$REF/$f" "$runpath/$f"
            done

            # run tests
            timeout 2m make -C "$runpath" test &>"$runpath/summary.txt"

            # check for compilation errors
            if [ -e "$runpath/$EXE" ]; then

                # summarize unit test results
                grep Checks "$runpath/tests/utests.txt"
                if [ -z "$(grep "C_" "$runpath/tests/utests.txt")" ]; then
                    if [ -z "$(grep "B_" "$runpath/tests/utests.txt")" ]; then
                        if [ -z "$(grep "A_" "$runpath/tests/utests.txt")" ]; then
                            ugrade="A"
                        else
                            ugrade="B"
                        fi
                    else
                        ugrade="C"
                    fi
                else
                    ugrade="D"
                fi

                # summarize integration test results
                grep FAIL "$runpath/tests/itests.txt" | grep -v X_
                grep "emory leak" "$runpath/tests/itests.txt"
                if [ -z "$(grep "C_.*FAIL" "$runpath/tests/itests.txt")" ]; then
                    if [ -z "$(grep "B_.*FAIL" "$runpath/tests/itests.txt")" ]; then
                        if [ -z "$(grep "A_.*FAIL" "$runpath/tests/itests.txt")" ]; then
                            igrade="A"
                        else
                            igrade="B"
                        fi
                    else
                        igrade="C"
                    fi
                else
                    igrade="D"
                fi

                # print summary
                echo "Unit test grade:        $ugrade"
                echo "Integration test grade: $igrade"
            else
                echo "Base grade: F (does not compile)"
            fi
        else
            echo "Base grade: F (incomplete submission)"
        fi
    else
        echo "Base grade: X (no submission)"
    fi

    echo ""
done

