#!/bin/bash

rm -rf ~/setup-cloudshell
git clone https://github.com/idfy/setup-cloudshell ~/setup-cloudshell
cd ~/setup-cloudshell
chmod u+x ~/setup-cloudshell/setup_cloudshell_ssh_config.sh
/bin/bash -c ~/setup-cloudshell/setup_cloudshell_ssh_config.sh