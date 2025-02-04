#!/bin/bash

# move to `script` folder
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

# move to root folder
cd ..

# apply the patch
echo "----------apply patch start----------"

for patch_file in $(ls ./scripts/patch | grep -E '^[0-9]{2}_.*\.patch$' | sort); do
    echo "> Applying patch: $patch_file"
    patch -p1 < "./scripts/patch/$patch_file"
done

echo "----------apply patch done----------"
