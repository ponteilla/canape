#!/bin/bash

set -e

args=("$@")

function __get_server_key() {
  [[ -f ".canape" ]] && source .canape

  if [ -z $TF_VAR_region ] || [ -z $TF_VAR_server_key ] || [ -z $TF_VAR_spot_price ]; then
    echo "You need to build first."
    exit 1
  fi

  export TF_VAR_region
  export TF_VAR_spot_price
  export TF_VAR_server_key
}

function __tf() {
  pushd terraform/providers/aws/parsec > /dev/null && terraform "$@" && popd > /dev/null
}

function build() {
  if [ -z ${args[1]} ]; then
    echo "You need to specify a server key."
    exit 1
  fi

  echo TF_VAR_region=${args[1]} > .canape
  echo TF_VAR_spot_price=${args[2]} >> .canape
  echo TF_VAR_server_key=${args[3]} >> .canape
  __get_server_key
  __tf init
  __tf apply
}

function destroy() {
  __get_server_key
  __tf destroy -force
  rm .canape 2> /dev/null
}

function start() {
  export TF_VAR_enabled=true
  __get_server_key
  __tf apply
  local instance_public_ip="$(__tf output -module=parsec instance_public_ip)"
  echo -e "\nYour instance public ip is: $instance_public_ip.\nIt will be ready soon."
}

function stop() {
  __get_server_key
  __tf apply
}

function main() {
  if [ -z ${args[0]} ]; then
    echo "usage: canape {build region bid_price server_key|destroy|start|stop}"
    exit 1
  fi

  ${args[0]}
}

main
