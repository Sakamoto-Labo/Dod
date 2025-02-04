#!/bin/bash

# move to `script` folder
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

echo "> Start installing SDK..."

# check if Ruby is installed
if command -v ruby &>/dev/null; then
    echo "✔ Ruby is already installed: $(ruby -v)"
else
    echo "> Ruby is not installed. Start installing Ruby..."

    # install Ruby
    sudo apt update -y
    sudo apt-get install ruby-full 

    # verify installation
    if command -v ruby &>/dev/null; then
        echo "> Verify installation..."
        echo "✔ Ruby is installed successfully: $(ruby -v)"
    else
        echo "✖︎ Ruby installation failed"
        exit 1
    fi
fi

# import cpp files into xcode
ruby add-shared-to-xcode.rb
if [ $? -ne 0 ]; then
    echo "✖︎ Import module failed."
    exit 1
else
    echo "✔ Finished Cpp files imported --> xcode"
fi

# apply patch
./apply-patch.sh

echo "✔ Finished installing SDK."
