#!/bin/bash
compute_name="ubuntu-jump"

echo "Terraform will Apply $compute_name"
echo "Using ../base/secrets.init.auto.tfvars"
echo "Using ../base/secrets.base.auto.tfvars.out"
echo "Using secrets.winsvr.auto.tfvars"
echo "Do you want to proceed? (yes/no)"
read -r answer

# Convert the answer to lowercase
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

# Check the user's answer
if [ "$answer" == "yes" ]; then
    echo "Proceeding..."

    cp -f ../base/secrets.init.auto.tfvars secrets.init.auto.tfvars
    cp -f ../base/secrets.base.auto.tfvars.out secrets.base.auto.tfvars

    export TF_VAR_compute_name="$compute_name"

    terraform workspace new "$compute_name" 2> /dev/null || sleep 0
    terraform workspace select "$compute_name"
    terraform init
    terraform validate
    terraform plan -out="$compute_name".plan
    terraform apply -auto-approve "$compute_name".plan
fi
