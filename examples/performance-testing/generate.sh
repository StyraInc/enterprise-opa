#!/usr/bin/env bash

set -eo pipefail

if command -v jq>/dev/null 2>&1 ; then
    echo "jq version: $(jq --version)"
else
    echo "jq not found"
    exit 1
fi
if command -v opa>/dev/null 2>&1 ; then
    echo "opa version: $(opa version | head -n 1 | cut -d ' ' -f 2)"
else
    echo "opa not found"
    exit 1
fi

echo "Generating test data with config:"

cat generate-config.json

temp_dir=$(mktemp -d)
data_file="$temp_dir"/data.json

load eval -d generate.rego -i generate-config.json data.generate | jq .result[0].expressions[0].value > "$data_file"

jq .queries "$data_file" > queries
mkdir -p bundle/
jq .users,.roles "$data_file" > bundle/data.json

echo "New bundle created in ./bundle"
du -sh bundle

rm -r "$temp_dir"
