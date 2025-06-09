#!/bin/bash

env=${1:-stage}

{

    if [ $? != 0 ] ; then
        exit 1
    fi

    IMAGE_NAME="5unof4beach/nestjs-boiler-plate:latest"

    docker compose -f ./prod/docker-compose.yml down api
    docker pull $IMAGE_NAME
    docker image rm $IMAGE_NAME || true

    if [[ "$env" == "production" ]]; then
        docker compose -f ./prod/docker-compose.yml up -d api
    elif [[ "$env" == "stage" ]]; then
        docker compose -f ./stg/docker-compose.yml up -d api
    else
        echo "Invalid env!"
        exit 1
    fi
} || {
    echo 'Failed. Aborted!'
}
