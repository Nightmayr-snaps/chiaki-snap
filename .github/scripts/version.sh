#!/bin/bash

git clone https://git.sr.ht/~thestr4ng3r/chiaki

# check latest released tagged version
LATEST_VERSION="$(cd chiaki && git describe --tags | sed 's/^v//')"
CURRENT_VERSION_SNAP="$(snap info chiaki | grep edge | head -n 2 | tail -n 1 | awk -F ' ' '{print $2}')"
rm -rf chiaki

# compare versions
if [ $CURRENT_VERSION_SNAP != $LATEST_VERSION ]; then
    echo "versions don't match, github: $LATEST_VERSION snap: $CURRENT_VERSION_SNAP"
    echo "BUILD=true" >> $GITHUB_ENV
    echo "LATEST_VERSION=$LATEST_VERSION" >> $GITHUB_ENV
    echo "CURRENT_VERSION_SNAP=$CURRENT_VERSION_SNAP" >> $GITHUB_ENV
else
    echo "versions match, github: $LATEST_VERSION snap: $CURRENT_VERSION_SNAP"
    echo "BUILD=false" >> $GITHUB_ENV
fi
