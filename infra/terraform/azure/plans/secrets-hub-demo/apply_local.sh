#!/bin/bash
isp_sub_domain="test-secrets-hub-demo"
terraform workspace new "$isp_sub_domain" 2> /dev/null || sleep 0
terraform workspace select "$isp_sub_domain"
terraform init
terraform validate
terraform plan -out="$isp_sub_domain".plan
terraform apply -auto-approve "$isp_sub_domain".plan
