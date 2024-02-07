#!/bin/bash

# CyberArk Tenant Parameters - should be passed in
tenant_id="aap4658"

###  NOTICE the bot user must have DPA Admin Role assigned
client_id="dennis_bot@westisp"
client_secret="?CuKJn>Is5@Eu|7r+Xf2~!JVVCHEtED*E\wgmy;+"

# CyberArk DPA Paramters
#475601244925
#10.78.10.33
#vpc-0a95284bdd3cd71ce
workspace_id="475601244925"
workspace_type="AWS"

# Remote Host and User Parameters - supplied by terraform
remote_host="54.215.35.126"
remote_user="ubuntu"


# Private key for remote host - supplied by terraform or CyberArk Secrets Management
priv_key_raw="-----BEGIN RSA PRIVATE KEY-----MIIEpAIBAAKCAQEA44krofLdmCchptT4hAfuv9LgivxUjepyWujkQy7L024j5aKiqTznJh+gJRy9FV9/mGimWKebjJSPa1r/dg3XPtluZXqUrl7/1dVR/ai213bo4K/CzjLdQaOXByXS8xho/OtkcRu7w0AWhing4VQi5IbqIIh5i6GmJ5uy5XIaxlvvgDAvO9hUt3S7v3ANTxJsgJQBQS4SjdwGbVGBcNcLMyvM9r2wqnRi711E0jk0jJ5uXCWa5YxDrn9U0h4gKpmQjkXGXJb3UUYDNor9/NGvVyVjG7UUiuyn2ARzuSlezUXQdL+J5n8igSIpYB7w9cZg521M5jamzVRpxlAEhQVUbwIDAQABAoIBAQClespn4si0cqkvuy3uYBKMIeK6Uh9wgvSeF0iDb9I/N5gV1z0zlh6KBHAk7Yy6sZSLlHh+e49OI3FW43xtME294MZAOXFOi7rGmnkh4QTxGQLu/gTQj/+IUGBzi1erArLAVrXa6Q+aRc7bzjNFzTn/N/uoo3i6S1sa7UqjQmQko7Kh3WENuxDeIdYGH3i3ozVk2ogWkGMikkLICTQlctXUqk4YBjHAt9+SNhT/CC2PkuOceOiCNekEr7M9dSIhs9bONSLL+gU/0oBYI0RtKD0Ihkru1CI7BkHKj5d5lkdN0U2G9h17j/lLORRjCid0EHvSEO+6K5YNPMFvgKk2OjSpAoGBAP9qMkMSX9O2xluheSH72af1DmiOwaW6JfVKD2yRKl5su+m90qTz+su0AebqYzDWTDG+b8Mz765BWjNj2fwAjpySNb1oK9ec9MQOLw4UXlyZWJJcQsOWFns9+KhTCuLgbbRvcn/aLKAW2ByN5ONxCn+09sT4oY1XKhv0gAk9eOjdAoGBAOQOn2zBQXgQbj6PGlY1T5FSL7a8l/8iaTSXI3GyrQ9j4hEGWoXfTAFR+0na2m6C5t5fsYebBNAbbneaVsUvABswBx0Ydul9ank99qshKOVJRKbTgcz2UQAOJ7wICS2Ah0oeczg4JyZX/lTK4xOtix3ZbxUa907KpxzW87YVvve7AoGAXgV8vR39cpUczcxSKAVq6R4XkLvEYzp0EKiTpvaFLz89qVy8NwatMuFvtc5gdzDb2Y/t2mC7AV2DU9mU++REmzRjXfcD9JoNrEJAZiFvXw0AAti9pvwQCIwWhfgT0NKm77362z+4H7JpGZHOST9qivpVwMp5xerpUGMf4sbjRG0CgYBWAd3GGiwip6+sEDQShxB28dPkysNYCRY8KzPG0WfLAhRj7018Z3Y2mUB33f2658tB2j0Nszzhbzb+DErlGpCjsD0+j9dov0/EYcYBTAQsVLF7aRDux4ZMywnZM/6iFnLvVQSHE0ZQg6b7O3jgFvb8TuBByWWzZWIY0kgfR5w5uQKBgQD1tnU51TOm0XGDAqW6C6NEd+CM5LYdZD1iUO6uVYiSc3sN+3rcKCdJ2MSjKkTP4U+UfTeHWLW3Tte4IBq/Oqa6IrEasEwGCmKb8coDdhs2IJkaiC6ZGkU4Ue+TYebPRf1B0TEBODxHwmj2eGxvdTaG0d37ebM6ZC6+Q9RSVFF92A==-----END RSA PRIVATE KEY-----"
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

base64_encoded_script=$(curl -s --location "https://$tenant_id.dpa.cyberark.cloud/api/public-keys/scripts?workspaceId=$workspace_id&workspaceType=$workspace_type" \
  --header "Authorization: Bearer $token") 

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