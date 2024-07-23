#!/bin/bash
rm -f secrets.base.auto.tfvars.out || sleep 0
isp_sub_domain="put_isp_sub_domain_here"
terraform workspace new "$isp_sub_domain" 2> /dev/null || sleep 0
terraform workspace select "$isp_sub_domain"
terraform init
terraform validate
terraform plan -out="$isp_sub_domain".plan
terraform apply -auto-approve "$isp_sub_domain".plan
rm -f local_files.tf
