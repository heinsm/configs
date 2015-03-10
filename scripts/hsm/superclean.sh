#!/bin/bash

#superclean
echo "supercleaning..."
read -p "Press [Enter] key to continue..."

echo "About to delete the following: "
find . -regex ".*\.\(\|o\)" -not -path "\.git"
find . -type f ! -name "*.*" -not -path "\.git"


read -p "Press [Enter] key to confirm..."

#clean all .o's
find . -regex ".*\.\(\|o\)" -not -path "\.git" | xargs rm -fv

#clean all non extension files (not make and not readmes)
find . -type f ! -name "*.*" -not -path "\.git" | grep -vi make | grep -vi readme | xargs rm -fv

echo "*****"
echo "DONE"
echo "*****"
echo "Conside running make clean