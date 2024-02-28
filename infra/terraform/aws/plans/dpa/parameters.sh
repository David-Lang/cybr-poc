#!/bin/bash

# Hardcoded for now.  Need to figure out how these propagate
secret_id='cybr-poc/westworld/dam-20240222'
region='us-west-2'
export workspaceID='475601244925'
export workspaceType='AWS'


##
### These should all be available from the TF build?
### Five k-v pairs in one AWS SM secret
##
sm_string=$(aws secretsmanager get-secret-value --secret-id $secret_id  --region $region | jq --raw-output '.SecretString')

export IspTenantId=$(echo $sm_string | jq .IspTenantId | sed 's/\\\\/\\/g' | sed 's/\"//g') #'abd4031'
export IspSubDomain=$(echo $sm_string | jq .IspSubDomain | sed 's/\\\\/\\/g' | sed 's/\"//g') #'westworld'
export IspSuffix=$(echo $sm_string | jq .IspSuffix | sed 's/\\\\/\\/g' | sed 's/\"//g') #'cyberark.cloud.15728'
export IspServiceClientId=$(echo $sm_string | jq .IspServiceClientId | sed 's/\\\\/\\/g' | sed 's/\"//g') #'dennis.bot@westworld'
export IspServiceClientSecret=$(echo $sm_string | jq .IspServiceClientSecret | sed 's/\\\\/\\/g' | sed 's/\"//g') #'t;uI\JDXc_R#mq\PTeuTn!h!pzU/2Gq/I~+iS@p#'


#echo $IspTenantId
#echo $IspSubDomain
#echo $IspSuffix
#echo $IspServiceClientId
#echo $IspServiceClientSecret

## AWS_PROGRAMMATIC KEYS should never be on the jumpbox
## because the jumpbox assumes a role and that role should be least_privilege - for audit




