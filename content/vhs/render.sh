#!/usr/bin/env bash

# Script to "render" the Hello World animated gif, demonstrating
# the memory savings of Styra Enterprise OPA compared to OPA. This script uses
# VHS https://github.com/charmbracelet/vhs to create three different
# gif files, which are finally concatenated into helloworld.gif
# The end result is likely going to be slightly different depending on
# things like bandwidth, so some of the sleep values might need to be
# adjusted accordingly.

# Prerequisites:
# `brew install gifsicle`
# `export STYRA_LOAD_LICENSE_KEY=...``
# Change the license key in load.tape to a valid one

cleanup() {
    rm -rf .opa

    local load_pid=$(lsof -t -i:8181)
    if [ -n "$load_pid" ]; then
        kill -9 "$load_pid"
    fi

    local opa_pid=$(lsof -t -i:8282)
    if [ -n "$opa_pid" ]; then
        kill -9 "$opa_pid"
    fi
}

# Run Styra Load

cleanup

brew remove --force --quiet styrainc/packages/load

rm -rf  load.gif \
        opa.gif \
        memory.gif \
        helloworld.gif \
        "$HOME"/Library/Caches/Homebrew/downloads/*load_Darwin_arm64

export HOMEBREW_NO_ENV_HINTS=1

vhs < load.tape

# Run OPA

cleanup

vhs < opa.tape

# Run both for comparison

cleanup

# Launch in background to allow script to keep running
load run -s https://dl.styra.com/load/bundle-load-400.tar.gz &
opa run -s -a localhost:8282 https://dl.styra.com/load/bundle-opa-400.tar.gz &

# Sleep for 4 minutes in order to read memory metrics from Load/OPA "at rest"
sleep 240

vhs < memory.tape

gifsicle --colors 256 load.gif opa.gif memory.gif > ../img/helloworld.gif

rm -rf load.gif opa.gif memory.gif

cleanup
