#!/bin/bash

IMAGE_NAME=marcelloromani1975/ububase:16.04

docker build -t $IMAGE_NAME . $@
docker push $IMAGE_NAME
