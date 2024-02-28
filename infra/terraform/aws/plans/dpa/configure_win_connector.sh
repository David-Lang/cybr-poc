#!/bin/bash

source ./parameters.sh

# From parameters.sh
#export IspTenantId='abd4031'
#export IspSubDomain='westworld'
#export IspSuffix='cyberark.cloud.15728'
#export IspServiceClientId='xxxxxxxxxxx'
#export IspServiceClientSecret='xxxxxxxxxxxx'

#export workspaceID='xxxxxx'
#export workspaceType='AWS'
connectorOS='windows'

# Let's authN and get a bearer token to interact with the tenant
echo "Authenticating as $IspServiceClientId on $IspTenantId..."
bearer_token=$(./get_bearer_token.sh $IspTenantId $IspServiceClientId $IspServiceClientSecret)

##
###  Get the script to remotely execute on the windows connector host
##
echo "Retrieving configuration script URL from tenant $IspSubDomain:: connector_type: $workspaceType, OS: $connectorOS..."
return=$(curl -s -X POST --location "https://$IspSubDomain-jit.cyberark.cloud/api/connectors/setup-script" \
--header "Content-Type: application/json" \
--header "Authorization: Bearer $bearer_token" \
--data "{\"connector_type\":\"$workspaceType\", \
         \"connector_os\":\"$connectorOS\"}")

#echo $return | jq .

tempscriptfile=$(mktemp)
echo $tempscriptfile
chmod 700 "$tempscriptfile" # ensure file is locked down and executable
trap "rm \"$tempscriptfile\"" 0 2 3 15 # ensure tempfile cleanup in event of various signals

script_url=$(echo $return | jq .script_url | sed 's/\"//g')

echo "Retrieving configuration script, placing in $tempscriptfile..." 
#echo $script_url

echo

config_script_fname="$tmp_dir/config_dpa_connector-$$.ps1"
wget -O $tempscriptfile $script_url

echo
more $tempscriptfile

###  CHECKPOINT 2/28/2024 - We have the .ps1 script and now need to SSH to the target and run the script.... 'expect'


