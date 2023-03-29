#!/bin/bash

if [ ! -d "/home/kaushik/.setup-cloudshell" ];
then
  git clone https://github.com/idfy/setup-cloudshell ~/.setup-cloudshell
else
  cd ~/.setup-cloudshell && git pull --ff-only origin main
fi

cd ~/.setup-cloudshell/cloudshell

cp -n ~/.setup-cloudshell/cloudshell/envrc ~/.envrc
cp -n ~/.setup-cloudshell/cloudshell/gitignore_global ~/.gitignore_global
cp -n ~/.setup-cloudshell/cloudshell/customize_environment.sh ~/.customize_environment

if [ -z "$(which direnv)" ];
then
  sudo apt -y install direnv
fi

if [ ! -d "~/.oh-my-bash" ];
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
fi

chmod +x ~/.setup-cloudshell/utils.sh && source ~/.setup-cloudshell/utils.sh

if ! grep -q "run_on_new_session" ~/.bashrc
then
  echo "run_on_new_session();" >> ~/.bashrc
fi
