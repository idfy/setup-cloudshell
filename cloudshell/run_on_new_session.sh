#!/bin/bash

split_on_dot () {
  IFS='.' read -ra input <<< "$1"
  echo input
}

k8s_proxy () {
  echo "forwarding ports - $IDFY_BASTION_PORT:8001 1$IDFY_BASTION_PORT:8002"
  gcloud compute ssh $3 --project $2 --zone "$IDFY_BASTION_ZONE" -- -L "$IDFY_BASTION_PORT":localhost:8001 -L "1$IDFY_BASTION_PORT":localhost:8002 kubectl proxy
}
