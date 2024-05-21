#!/bin/bash

# Execution context - fms-docker repo
cd "$(dirname "$0")"/..

# env -> REPO, IMAGE, VERSION, UBUNTU, PROCESSOR
[ ! -f .env ] && exit 1
source .env

# Major version
ver=${VERSION%%.*}

# Container name
container=fms-$ver-prep

# Image name and tag
if [ ! -z $REPO ]; then
    tag=$IMAGE-$VERSION-u$UBUNTU-$PROCESSOR
    image=$REPO:$tag                # ex: jackdeaniels/private:yeda-fms-19.6.4.402-u22-amd
else
    tag=$VERSION-u$UBUNTU-$PROCESSOR
    image=$IMAGE:$tag
fi

# Commit running container into image
echo Committing $container into $image
docker commit $container $image
echo Stopping $container 
docker stop $container

# Push
if [ ! -z $REPO ]; then
    read -n 1 -p "Push $tag to $REPO? [y/N]" push 
    echo ""
    if [ "$push" == "y" ] || [ "$push" == "Y" ]; then
        docker login
        docker push $image
    fi
fi