#!/bin/bash

set -e

TIME_INTERVAL=$1
TIME_INTERVAL=${TIME_INTERVAL:-15}


echo "Deploying dockerized client (Time interval $TIME_INTERVAL seconds)..."
RESPONSE=$(curl -w %{http_code} -s -o /dev/null -H "Content-type: application/json" -X POST http://127.0.0.1:8080/v2/apps -d @- << EOF
{
  "id": "dockerized-client",
  "cmd": "while [ true ] ; do curl -s 127.0.0.1:10001 ; sleep $TIME_INTERVAL ; done",
  "cpus": 0.1,
  "mem": 32,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "docker": {
      "image": "tutum/curl:alpine",
      "network": "HOST",
      "forcePullImage": true
    }
  }
}
EOF
)
if [ $RESPONSE -eq 200 ] || [ $RESPONSE -eq 201 ]; then
  echo "Client successfully deployed."
else
  echo "Client deployment unsuccessful. Got $RESPONSE"
fi
