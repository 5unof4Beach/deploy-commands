#!/bin/bash

env=${1:-stage}

{

    if [ $? != 0 ] ; then
        exit 1
    fi

    IMAGE_NAME="5unof4beach/nestjs-boiler-plate:latest"

    docker compose -f ./prod/docker-compose.yml down
    docker pull $IMAGE_NAME


    if [[ "$env" == "production" ]]; then
        docker compose -f ./prod/docker-compose.yml up -d
    elif [[ "$env" == "stage" ]]; then
        docker compose -f ./stg/docker-compose.yml up -d
    else
        echo "Invalid env!"
        exit 1
    fi
} || {
    echo 'Failed. Aborted!'
}
