# shellcheck disable=SC2129
# shellcheck disable=SC2154
# shellcheck disable=SC2086
# shellcheck disable=SC2016
echo "Create Terraform Cloud Variable Set via Curl:" > varset_create.log

curl -X POST \
     --location https://app.terraform.io/api/v2/organizations/${terraform_cloud_org_name}/varsets \
     --header "Authorization: Bearer ${terraform_cloud_api_key}" \
     --header 'Content-Type: application/vnd.api+json' \
     --data-raw '{ "data": {
         "type": "varsets",
         "attributes": {
           "name": "workspace-${name_prefix}",
           "description": "workspace varset ",
           "global": false,
           "priority": false
         },
         "relationships": {
           "workspaces": {
             "data": [
               {
                 "id": "${terraform_cloud_ws_id}",
                 "type": "workspaces"
               }
             ]
           },
           "vars": {
             "data": [
               {
                 "type": "vars",
                 "attributes": {
                   "key": "vpc_id",
                   "value": "${vpc_id}",
                   "category": "terraform"
                 }
               },
               {
                 "type": "vars",
                 "attributes": {
                   "key": "vpc_cidr",
                   "value": "${vpc_cidr}",
                   "category": "terraform"
                 }
               },
               {
                 "type": "vars",
                 "attributes": {
                   "key": "vpc_private_subnet_ids",
                   "value": "${vpc_private_subnet_ids}",
                   "category": "terraform"
                 }
               },
               {
                 "type": "vars",
                 "attributes": {
                   "key": "vpc_public_subnet_ids",
                   "value": "${vpc_public_subnet_ids}",
                   "category": "terraform"
                 }
               },
               {
                 "type": "vars",
                 "attributes": {
                   "key": "keypair_name",
                   "value": "${keypair_name}",
                   "category": "terraform"
                 }
               },
               {
                 "type": "vars",
                 "attributes": {
                   "key": "allowlist_sg_id",
                   "value": "${allowlist_sg_id}",
                   "category": "terraform"
                 }
               },
               {
                 "type": "vars",
                 "attributes": {
                   "key": "base_tags",
                   "value": "${base_tags}",
                   "category": "terraform"
                 }
               }
             ]
           }
         }
       }
     }
     ' | jq . >> varset_create.log

