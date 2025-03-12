#!/bin/bash
eks_name="test-eks"

echo "Terraform will Apply $eks_name"
echo "Using ../base/secrets.init.auto.tfvars"
echo "Using ../base/secrets.base.auto.tfvars.out"
echo "Do you want to proceed? (yes/no)"
read -r answer

# Convert the answer to lowercase
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

# Check the user's answer
if [ "$answer" == "yes" ]; then
    echo "Proceeding..."

    cp -f ../base/secrets.init.auto.tfvars secrets.init.auto.tfvars
    cp -f ../base/secrets.base.auto.tfvars.out secrets.base.auto.tfvars

    export TF_VAR_eks_name="$eks_name"

    terraform workspace new "$eks_name" 2> /dev/null || sleep 0
    terraform workspace select "$eks_name"
    terraform init
    terraform validate
    terraform plan -out="$eks_name".plan
    terraform apply -auto-approve "$eks_name".plan
fi
