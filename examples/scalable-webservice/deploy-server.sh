#!/bin/bash

set -e

echo "Deploying MARATHON Load Balancer..."
RESPONSE=$(curl -H "Content-type: application/json" -X POST http://127.0.0.1:8080/v2/apps -d @marathon-lb.json -w %{http_code} -s -o /dev/null)
if [ $RESPONSE -eq 200 ] || [ $RESPONSE -eq 201 ]; then
  echo "Successfully deployed MARATHON Load Balancer."
else
  echo "MARATHON Load Balancer deployment unsuccessful. Got $RESPONSE"
fi

echo -e "\nDeploying NGINX server(s)..."
RESPONSE=$(curl -H "Content-type: application/json" -X POST http://127.0.0.1:8080/v2/apps -d @nginx-server.json -w %{http_code} -s -o /dev/null)
if [ $RESPONSE -eq 200 ] || [ $RESPONSE -eq 201 ]; then
  echo "Successfully deployed NGINX server(s)."
else
  echo "NGINX server(s) deployment unsuccessful. Got $RESPONSE"
fi
