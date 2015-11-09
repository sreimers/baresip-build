#!/bin/bash
set -e

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
    sudo apt-get update -qq
    sudo apt-get install -y libssl-dev
    sudo rm -f /usr/lib/x86_64-linux-gnu/libcrypto.so
    sudo rm -f /usr/lib/x86_64-linux-gnu/libssl.so
fi
