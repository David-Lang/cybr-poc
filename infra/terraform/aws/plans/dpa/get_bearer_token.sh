#!/bin/bash

tenant_id=$1
client_id=$2
client_secret=$3

#echo $tenant_id
#echo $client_id
#echo $client_secret

token=$(curl -s --location "https://$tenant_id.id.cyberark.cloud/oauth2/platformtoken" \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'grant_type=client_credentials' \
  --data-urlencode "client_id=$client_id" \
  --data-urlencode "client_secret=$client_secret" | jq .access_token | sed 's/"//g')

echo $token
