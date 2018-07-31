#!/bin/bash

echo -e "\n"
echo -e "====================================================================="
echo -e "==                        BUILDING PROJECTS                        =="
echo -e "====================================================================="
echo -e ""
./rebuild-pT.sh
./rebuild-p0.sh

echo -e "\n"
echo -e "====================================================================="
echo -e "==                  TESTING PROJECT DISTRIBUTIONS                  =="
echo -e "====================================================================="
echo -e ""
make -s -C pT-blank test
make -s -C p0-intro test

echo -e "\n"
echo -e "====================================================================="
echo -e "==                         TESTING SOLUTIONS                       =="
echo -e "====================================================================="
echo -e ""
make -s -C pT-blank-soln test
make -s -C p0-intro-soln test

