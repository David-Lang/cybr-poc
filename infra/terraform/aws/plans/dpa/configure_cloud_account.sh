#!/bin/bash

# CyberArk Tenant Parameters - should be passed in
source ./parameters.sh

# From parameters.sh
#export IspTenantId='abd4031'
#export IspSubDomain='westworld'
#export IspSuffix='cyberark.cloud.15728'
#export IspServiceClientId='xxxxxxxxxxx'
#export IspServiceClientSecret='xxxxxxxxxxxx'

#export workspaceID='xxxxxx'
#export workspaceType='AWS'

workspaceName="Americas SE AWS Account"

echo "Adding $workspaceType account $workspaceID to tenant $IspSubDomain ($IspTenantId)..."

bearer_token=$(./get_bearer_token.sh $IspTenantId $IspServiceClientId $IspServiceClientSecret)
#echo $token

curl -o /dev/null -s -w "(%{http_code}) %{response_body}\n" -X POST --location "https://$IspSubDomain-jit.cyberark.cloud/api/discovery/accounts" \
--header "Content-Type: application/json" \
--header "Authorization: Bearer $bearer_token" \
--data "{\"account_id\":\"$workspaceID\", \
         \"name\":\"$workspaceName\", \
         \"description\":\"from cybr-poc\", \
         \"validate_ssh_fingerprint\":true}"

#echo "Status: ($?) $return"
echo

#https://discovery-ctrust-445444212982-jenkinsdiscoverymaster.s3.amazonaws.com/rendered/tenant_1151b0e0-12c0-460a-ba47-f7e80c74f8a1/account_475601244925/cf_template_475601244925_trustDPA.yml?versionId=LOhjMUbE_gDRVyLesp5ntKdxvbqqxRNo&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAWPNULJD3EOUFWEEK%2F20240221%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240221T170420Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGAaCXVzLWVhc3QtMSJGMEQCIArmgBfVE2ApF3gt9aTRY79GLjPwyIS%2FBcwa0J9zTy24AiBEoJIF6V5HuAvBZVmPvEsgiS6kEAnLl%2FWTSo3d%2F7AzJyrPAwhJEAMaDDQ0NTQ0NDIxMjk4MiIMQOQ%2BDDhRTHR34O17KqwD6i8nk7fq1wWW%2BwRLRDe30qp3Aaj9Kn%2BDrV53PVhH0rSxb6hhCU1wZeqp%2BdbROqUlHcX%2BtaOzZcHyHu8ovJciMQ8IZbJQsiYI4PygW1a0hYn4WsVAr%2FlSZhOVNONaCOfybtbkeJMGHGzfueVhWHqxBzmbLLAhGvR24BBzgvsXu1M8lG%2FrAdxmAMvQH%2BJIbRc%2BbfSNcyztrbbokXeW%2FZQt6impuplKAgXRYXomfmODaPAas5VCSmPmSFrR8xo9SuOu3kuQoGlSVWb09ajD5%2F1FxKSpM31RlkofdGZfEJ5bJzk1a%2Fb79dzPlI1ra%2FPF1khD%2Bgp6cOGUUQVbLR9VnLo%2BpwjeY3M2DixF5OV0E1rkZy8e%2Bp27pxnvYYlh2uwNaaHtzW4IliEvlzj41SAWWq21Fvdr3xW7lDotv5mRnyrnAPo2rQTA2HTdFKUoYOTJ4haO1EXD2dDI7Xez3nHpnPoIh3HzsZO7TgjKo1vkOOUcdRvXw0%2Fy24%2FK6C01GsLKedhbywMAfATajOMQ3l%2Bjih4VpMKVoFp37cbphLRy5wqU1FgOmQ1sGnLEncmyvFQw8qzYrgY6nwGun%2F%2BStdR2SNKbpxpOeYaNpuYFNBEamldA7upQU7gamElD8waR4gPnDLlAwnfzu1Xklx8MCDHsKQf%2BvYEHeIkW7bnAzJ%2Btr9BxKjLfdeyfF%2FRL8Dl4ogoVMoZhxHfU8HRbFEfCxTqhNFRGvjicQ9RU0XftsFDFjabUp12dKRm1iXtEyai6GuSZ%2FSPmjlUS4LAgxhPIpphe2ZY7elecoY4%3D&X-Amz-Signature=00db2f9678a128905f9f358a78c4b42c4dcca61878da4b313f7d4b9c2280adfd

"https://discovery-ctrust-445444212982-jenkinsdiscoverymaster.s3.amazonaws.com/rendered/tenant_1151b0e0-12c0-460a-ba47-f7e80c74f8a1/account_475601244925/cf_template_475601244925_trustDPA.yml?versionId=fV17M3nYa0Zk.EVVt67KoasG4Dme.Jft&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAWPNULJD3MBIYV4K6%2F20240225%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240225T005455Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Security-Token=IQoJb3JpZ2luX2VjELH%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIADPvBw0DRT5PLnzpu5oFw4x0yyrdgSTvmcIvr4uDqc4AiEAxX1dx3qaHw619pYjb%2BrSBADw521vdCERZdL28uGVnJ4q2AMImv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARADGgw0NDU0NDQyMTI5ODIiDI9WtSR42%2Bbip2eI5CqsAxz4IynpqhyO1AS8YAANaYie2xDpYv1Mbwby%2FAtsucEFnDVEoMvc%2BtxMOahTout%2FlX3%2Fij%2FYegBh%2BKuy42KMJaSBzTIErSjmMbkSLKt0qhvBQ3BoFBV0q9AuE%2FY9zSQiGgsDj%2FB9VBPnlSAeqCzp3XQxEee%2BOJQDdxA9gta%2FY0ofHYXX24V3NJlhNhxT6VWN7K3e4FnNpb%2B4EcGstjqp%2B9HoutUi4MMNXiJh23uG460rrV%2F9FrWsVB0ULK2EPK%2BTkwrM19Z9%2FvahlAPkVorHGEznWSxm%2BRbkdeZVijQDKAK03nJogNDKBgd2I%2FqFCDZAdAHhjtrT7%2FqK%2BvrJ6DtiK7eOmi%2F%2FGBstkWQtjDR8Q7i9nchvi8F0I1aGlISBBeUN20fUoK%2FL6ZSx9R%2BYysk1jJ3OrLRY4fKONbgiQcmzRsvQQA4g750Vg1I7VvPIKU%2FA0OFas96TcAxvtHDNmHng51NCyQDWDL2q3EOundELzrcfv6eljScOLgJJAPFGCwQK2cYHwTOHAkX6iG%2BqoWpW4Qfq%2Bw%2FfC2UBI9RfVkuSmdbIBILANZ%2FLgUxnudzOMNeY6q4GOp4B2UEQRE3PpGvavxL2H0cRql2T48NzXRl9SJVcujLHtuVj788LZgYtoM6xxcaf%2F3buNx2TuzMrWtGMdEYfVUSZVzwlwDijcV2rXTxa5gDnm7ncxv9S9VYuKJsOM4qu3vU7Mxm9pHW6yDfFCjd8xSZP2urJXkQdClGH20bcm%2FoGP3R2xpaD3ozfd0Qm0EtItjbrtVAAcq%2FrXFz0J9pplj0%3D&X-Amz-Signature=a97cd0b2020d8edb88090ad114826b9aacf8b288dcfd9f53dc91f4c103305f2c"
