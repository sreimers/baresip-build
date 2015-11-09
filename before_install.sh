#!/bin/bash

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
    apt-get update -qq
    apt-get install -y libssl-dev
    rm -f /usr/lib/x86_64-linux-gnu/libcrypto.so
    rm -f /usr/lib/x86_64-linux-gnu/libssl.so
fi
