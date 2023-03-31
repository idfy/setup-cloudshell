#!/bin/bash

ssh2config() {
  comm -23 <(ssh -G "$@" | sort) <(ssh -G abcddd | sort) | sed 's/^/  /'
}

op=$(gcloud cloud-shell ssh --authorize-session --quiet --dry-run | awk -F'--' '{ print $1 }')
args=$(echo $op | awk -F'ssh ' '{ print $2 }')

echo "# start cloudshell_ssh_config" > ~/.ssh/cloudshell_ssh_config
echo "host cloudshell" >> ~/.ssh/cloudshell_ssh_config
ssh2config $args >> ~/.ssh/cloudshell_ssh_config
echo "# end cloudshell_ssh_config" >> ~/.ssh/cloudshell_ssh_config

sed -i.bak '/# start cloudshell_ssh_config/,/# end cloudshell_ssh_config/d' ~/.ssh/config
cat ~/.ssh/cloudshell_ssh_config >> ~/.ssh/config
rm ~/.ssh/cloudshell_ssh_config

echo "Done.. Choose 'cloudshell' remote host in VS Code.."
