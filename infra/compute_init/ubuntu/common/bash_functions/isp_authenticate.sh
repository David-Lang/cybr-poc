


curl --location "https://$TENANT_PREFIX.id.cyberark.cloud/oauth2/platformtoken" \
--header 'X-IDAP-NATIVE-CLIENT: true' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode "client_id=$ISP_LOGIN" \
--data-urlencode "client_secret=$ISP_KEY"

