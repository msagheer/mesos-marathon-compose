# Sample Application

## Usage

### Deploy Server
- Run `./deploy-server.sh` to deploy NGINX server(s) behind marathon-lb

### Deploy Client
- Run `./deploy-client.sh` to launch a dockerized client which **curls** server periodically.

By default client will make a curl call to the server after every 15 seconds, which can be configured by running above script with seconds
as argument.

Tail client logs using `docker logs` command to view curl results. 

### Scale Server
- Run `./scale-server.sh 5`to scale NGINX server(s) to desired instances.

Above example will scale NGINX server(s) to 5 instances.

### Update Server
- Run `./update-server.sh 1.12` to update NGINX server(s) docker image tag.

Above example will update NGINX server(s) docker image to **1.12** tag.

**NOTE:** Make sure to provide correct docker image tag.
