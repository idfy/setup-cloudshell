#!/bin/bash

eval "$(direnv hook bash)"

echo "Web host base URL is ${WEB_HOST}"
echo "Prepend the port on which your server is running. eg - https://8080-${WEB_HOST}"

direnv allow;

source ~/.setup-cloudshell/cloudshell/utils.sh