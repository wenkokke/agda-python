#!/bin/bash

# Update Cabal package list:
cabal update

# Get OS release information:
source /etc/os-release

# CentOS 7
# Link libtinfo.so.5 -> libtinfo.so so GHC can find it:
if [ "$ID" = "centos" -a "$VERSION_ID" = "7" ]; then
    ln -s /lib64/libtinfo.so.5 /lib64/libtinfo.so
fi
