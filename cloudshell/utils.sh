#!/bin/bash

stop_bastion () {
  gcloud compute instances stop "$IDFY_BASTION_NAME" --zone "$IDFY_BASTION_ZONE" --project "$IDFY_PROJECT_ID"
}

start_bastion () {
  gcloud compute instances start "$IDFY_BASTION_NAME" --zone "$IDFY_BASTION_ZONE" --project "$IDFY_PROJECT_ID"
}

bastion () {
  echo "forwarding ports - $IDFY_BASTION_PORT:8001 $IDFY_BASTION_PORT:8002"
  gcloud compute ssh "$IDFY_BASTION_NAME" --project "$IDFY_PROJECT_ID" --zone "$IDFY_BASTION_ZONE" -- -L "$IDFY_BASTION_PORT":localhost:8001 -L "1$IDFY_BASTION_PORT":localhost:8002
}

run_on_bastion () {
  gcloud compute ssh "$IDFY_BASTION_NAME" --project "$IDFY_PROJECT_ID" --zone "$IDFY_BASTION_ZONE" --command $1
}

k8s_proxy () {
  echo "forwarding ports - $IDFY_BASTION_PORT:8001 1$IDFY_BASTION_PORT:8002"
  gcloud compute ssh "$IDFY_BASTION_NAME" --project "$IDFY_PROJECT_ID" --zone "$IDFY_BASTION_ZONE" -- -L "$IDFY_BASTION_PORT":localhost:8001 -L "1$IDFY_BASTION_PORT":localhost:8002 kubectl proxy
}

ssh_vm () {
  echo "+ gcloud compute ssh $1 --project $2 --zone $3 --tunnel-through-iap"
  gcloud compute ssh "$1" --project "$2" --zone "$3" --tunnel-through-iap
}

echo_k8s_port_fwd () {
  echo "kubectl port-forward $1 8001: -n $3"
}

rmq_proxy () {
  gcloud compute ssh "$IDFY_RMQ_NAME" --project "$IDFY_PROJECT_ID" --zone "$IDFY_RMQ_ZONE" -- -L 2222:localhost:15672
}

get_remote_cert () {
  echo | openssl s_client -showcerts -connect $1:443 2>/dev/null
}

get_remote_cert_expiry () {
  echo | openssl s_client -connect $1:443 2>/dev/null | openssl x509 -noout -dates
}

stop_vm () {
  gcloud compute instances stop $1 --project $2 --zone $3
}

start_vm () {
  gcloud compute instances start $1 --project $2 --zone $3
}

split_on_dot () {
  IFS='.' read -ra input <<< "$1"
  echo input
}

banner_on_new_session () {
  echo "Web host base URL is ${WEB_HOST}"
  echo "Prepend the port on which your server is running. eg - https://8080-${WEB_HOST}"
}