#!/bin/bash

set -e

NGINX_TAG=$1
NGINX_TAG=${NGINX_TAG:-1.12}

echo "Updating NGINX server(s) to $NGINX_TAG tag..."
RESPONSE=$(curl -w %{http_code} -s -o /dev/null -H "Content-type: application/json" -X PUT http://127.0.0.1:8080/v2/apps/nginx-server -d @- << EOF
{
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "nginx:$NGINX_TAG",
      "network": "BRIDGE",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 0,
          "servicePort": 10001,
          "protocol": "tcp"
        }
      ],
      "forcePullImage": true
    }
  }
}
EOF
)
if [ $RESPONSE -eq 200 ] || [ $RESPONSE -eq 201 ]; then
  echo "NGINX server(s) updated successfully."
else
  echo "NGINX server(s) update unsuccessful. Got $RESPONSE"
fi
