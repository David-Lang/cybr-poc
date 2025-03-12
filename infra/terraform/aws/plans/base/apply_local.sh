#!/bin/bash
rm -f secrets.base.auto.tfvars.out || sleep 0
#isp_sub_domain="put_isp_sub_domain_here"

echo "Terraform will Apply cybr-poc base"
echo "Using secrets.init.auto.tfvars"
cat secrets.init.auto.tfvars && echo
echo "Do you want to proceed? (yes/no)"
read -r answer

# Convert the answer to lowercase
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

# Check the user's answer
if [ "$answer" == "yes" ]; then
    echo "Proceeding..."

#    export TF_VAR_isp_sub_domain="$isp_sub_domain"

    terraform workspace new cybr-poc 2> /dev/null || sleep 0
    terraform workspace select cybr-poc
    terraform init
    terraform validate
    terraform plan -out=cybr-poc.plan
    terraform apply -auto-approve cybr-poc.plan
fi
