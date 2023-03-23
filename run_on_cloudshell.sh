#!/bin/bash
git clone https://github.com/idfy/setup-cloudshell ~/setup-cloudshell

mv ~/setup-cloudshell/.envrc ~/.envrc
mv ~/setup-cloudshell/.gitignore_global ~/.gitignore_global

if [ -z "$(which direnv)" ]; then
  sudo apt -y install direnv
fi

if [ ! -d "/home/kaushik/.oh-my-bash" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
fi

source ~/setup-cloudshell/utils.sh

banner_on_new_session()