#!/bin/bash

set -e

INSTANCES=$1
INSTANCES=${INSTANCES:-5}

echo "Scaling NGINX server(s) to $INSTANCES instance(s)..."
RESPONSE=$(curl -w %{http_code} -s -o /dev/null -H "Content-type: application/json" -X PUT http://127.0.0.1:8080/v2/apps/nginx-server -d @- << EOF
{
  "instances": $INSTANCES
}
EOF
)
if [ $RESPONSE -eq 200 ] || [ $RESPONSE -eq 201 ]; then
  echo "NGINX server(s) scaled successfully."
else
  echo "NGINX server(s) scaling unsuccessful. Got $RESPONSE"
fi
