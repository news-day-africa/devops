#!/usr/bin/env sh

set -e

export IP_ADDRESS=$1
export SSH_KEY=$2
export MACHINE_NAME=$3

function make_docker_machine(){
    docker-machine create \
	--driver=generic \
	--generic-ip-address=$IP_ADDRESS \
	--generic-ssh-key=$SSH_KEY \
	$MACHINE_NAME
}

function start_drone_ci(){
    eval $(docker-machine env $MACHINE_NAME)
    source env.sh && \
	docker-compose up -d
}

function setup_drone_ci_github(){
  source env.sh
  drone secret add --image=themast/docker-wp-theme-build:latest \
  the-mast/the-mast-theme \
  GITHUB_TOKEN $GITHUB_TOKEN
}

function main(){
    make_docker_machine
    start_drone_ci
    setup_drone_ci_github
}

main $@

