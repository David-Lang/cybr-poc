#!/bin/bash

# CyberArk Tenant Parameters - should be passed in
tenant_id="foo"

###  NOTICE the bot user must have DPA Admin Role assigned
client_id="foofo"
client_secret="fofo"

# CyberArk DPA Paramters
workspace_id="475601244925"
workspace_type="AWS"

# Remote Host and User Parameters - supplied by terraform
remote_host="54.215.35.126"
remote_user="ubuntu"

# Private key for remote host - supplied by terraform or CyberArk Secrets Management
priv_key_raw="-----BEGIN RSA PRIVATE KEY-----XXXXXXXXXXXXX-----END RSA PRIVATE KEY-----"
priv_key=$(echo $priv_key_raw | sed 's/\(KEY-----\)/\1\n/' | sed 's/\(-----END\)/\n\1/')
#echo $priv_key

##########################################
# Don't Change Parameters Below this...
##########################################

token=$(curl -s --location "https://$tenant_id.id.cyberark.cloud/oauth2/platformtoken" \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'grant_type=client_credentials' \
  --data-urlencode "client_id=$client_id" \
  --data-urlencode "client_secret=$client_secret" | jq .access_token | sed 's/"//g')

#echo $token

base64_encoded_script=$(curl --location "https://$tenant_id.dpa.cyberark.cloud/api/connectors/setup-script"\
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $token"   \
  --data '{
    "connector_type": "AWS",
    "connector_os": "windows"
  }')

#echo $base64_encoded_script
script=$(echo $base64_encoded_script | jq .base64_cmd | sed 's/"//g' | base64 --decode)
#echo $script

# Create a trap function to delete the temporary key and script files on script termination
cleanup() {
    rm -f "$key_file" "$script_file"
    exit
}

# Register the cleanup function to catch all signals that can terminate the script
trap cleanup EXIT INT TERM

# Create a temporary file to store the private key
key_file=$(mktemp)
chmod 600 "$key_file"
echo "$priv_key" > "$key_file"
#cat $key_file

# Create a temporary file to store the base64 encoded script
script_file=$(mktemp)
chmod 600 "$script_file"
echo "$script" > "$script_file"
#cat $script_file

# Securely execute the script on the remote host using SSH with the private key
#ssh -o StrictHostKeyChecking=no -i $key_file $remote_user@$remote_host
ssh -o StrictHostKeyChecking=no -i "$key_file" "${remote_user}@${remote_host}" "bash -s" < "$script_file"