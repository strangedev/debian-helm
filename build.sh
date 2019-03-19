#!/bin/bash
IMAGE_NAME="debian-helm-buildenv"

if [ -z ${1+x} ]; then
	OUT_DIR="$(pwd)/out"
else
	OUT_DIR=$1
fi

docker build -t $IMAGE_NAME .

docker run \
	-v ${OUT_DIR}:/out \
	$IMAGE_NAME