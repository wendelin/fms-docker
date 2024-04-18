#!/bin/bash

# Absolute paath
versions=$(dirname $(readlink -f $0))
dir=$(readlink -f $versions/../..)
echo $dir

# env -> LICENSE
$dir/env.sh
source $dir/.env

# License must be defined
if [ -z $LICENSE ]; then
    echo LICENSE env variable not defined, cannot generate download link
    exit 1
fi

# Open downlosd link
baseUrl=https://accounts.claris.com/software/license
xdg-open $baseUrl/$LICENSE
# On SSH, will open on the connecting machine 