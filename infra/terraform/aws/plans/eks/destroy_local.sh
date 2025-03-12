#!/bin/bash
echo "Terraform workspace to destroy:"
terraform workspace show

echo "Do you want to proceed? (yes/no)"
read -r answer

# Convert the answer to lowercase
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

# Check the user's answer
if [ "$answer" == "yes" ]; then
    echo "Proceeding..."
    export TF_VAR_eks_name="eks_destroy"
    terraform destroy -auto-approve
fi
