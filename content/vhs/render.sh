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
# `export EOPA_LICENSE_KEY=...``
# Change the license key in enterprise-opa.tape to a valid one

cleanup() {
    rm -rf .opa

    local eopa_pid=$(lsof -t -i:8181)
    if [ -n "$eopa_pid" ]; then
        kill -9 "$eopa_pid"
    fi

    local opa_pid=$(lsof -t -i:8282)
    if [ -n "$opa_pid" ]; then
        kill -9 "$opa_pid"
    fi
}

# Run Styra Enterprise OPA

cleanup

brew remove --force --quiet styrainc/packages/enterprise-opa

rm -rf  enterprise-opa.gif \
        opa.gif \
        memory.gif \
        helloworld.gif \
        "$HOME"/Library/Caches/Homebrew/downloads/*eopa_Darwin_arm64

export HOMEBREW_NO_ENV_HINTS=1

vhs < enterprise-opa.tape

# Run OPA

cleanup

vhs < opa.tape

# Run both for comparison

cleanup

# Launch in background to allow script to keep running
eopa run -s https://dl.styra.com/enterprise-opa/bundle-enterprise-opa-400.tar.gz &
opa run -s -a localhost:8282 https://dl.styra.com/enterprise-opa/bundle-opa-400.tar.gz &

# Sleep for 4 minutes in order to read memory metrics from Enterprise OPA/OPA "at rest"
sleep 240

vhs < memory.tape

gifsicle --colors 256 enterprise-opa.gif opa.gif memory.gif > ../img/helloworld.gif

rm -rf enterprise-opa.gif opa.gif memory.gif

cleanup
