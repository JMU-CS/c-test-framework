#!/bin/bash
#
# Rebuild a student distribution:
#   * copy files from reference solution into temporary folder
#   * remove solutions and enable boilerplate code
#   * generate tarball and zip file
#
# Mike Lam, James Madison University, Fall 2016
#

function cleanup {
    sed -e '/BEGIN_SOLUTION/,/END_SOLUTION/d' "$REF/$1" >tmp
    sed -e 's/\/\/ BOILERPLATE: //g' tmp >$ROOT/$1
    rm tmp
}

# paths
ROOT=pT-blank
REF=../ref/pT-blank

# set up distribution folder
rm -rf $ROOT
mkdir $ROOT
mkdir $ROOT/tests
mkdir $ROOT/tests/inputs
mkdir $ROOT/tests/expected

# rebuild
make -C $REF clean
make -C $REF

# generic files
cleanup "Makefile"
cleanup "main.c"

# project-specific files
cleanup "pT-blank.h"
cleanup "pT-blank.c"

# testsuite
make -C $REF/tests
cp -H $REF/tests/testsuite.c       $ROOT/tests/
cp -H $REF/tests/public.c          $ROOT/tests/
cp -H $REF/tests/integration.sh    $ROOT/tests/
cp -H $REF/tests/inputs/*          $ROOT/tests/inputs/
cp -H $REF/tests/expected/*        $ROOT/tests/expected/
cp -H $REF/tests/itests.include    $ROOT/tests/
cp -H $REF/tests/private.o         $ROOT/tests/
strip -S $ROOT/tests/private.o
cat $REF/tests/Makefile | sed -e '/^MODS/d' | sed -e 's/^#MODS/MODS/g' \
                        | sed -e '/^OBJS/d' | sed -e 's/^#OBJS/OBJS/g' >$ROOT/tests/Makefile

# build tarball and zip file
tar -zchvf $ROOT.tar.gz $ROOT

# create solution folder (for testing)
rm -rf $ROOT-soln
cp -r $ROOT $ROOT-soln
cp -H $REF/main.c                  $ROOT-soln/
cp -H $REF/pT-blank.c              $ROOT-soln/

