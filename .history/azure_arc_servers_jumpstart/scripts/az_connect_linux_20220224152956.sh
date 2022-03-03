#!/bin/bash

# <--- Change the following environment variables according to your Azure service principal name --->

echo "Exporting environment variables"
export subscriptionId='9c12f367-e8d2-4770-a3a2-6d2a77a53d08'
export appId='fcf40186-6615-4ddc-87a6-bdf113abc420'
export password='RgaC_5ZlKRPRQvpyhUv_4cuSAMd8Bw9YJc'
export tenantId='7c8a0cba-49a7-462c-aa5e-e50faee4beee'
export resourceGroup='Azure-Arc'
export location='southeastasia'

# Determine Package Manager

if INST="$( which apt-get )" > /dev/null 2>&1; then
   sudo apt-get update
elif INST="$( which yum )" > /dev/null 2>&1; then
   sudo yum -y update
elif INST="$( which zypper )" > /dev/null 2>&1; then
   sudo zypper ref
   sudo zypper update -y
else
   echo "No package manager found, check Azure Arc enabled servers supported OS" >&2
   exit 1
fi

# Download the installation package
wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh

# Run connect command
sudo azcmagent connect \
  --service-principal-id "${appId}" \
  --service-principal-secret "${password}" \
  --resource-group "${resourceGroup}" \
  --tenant-id "${tenantId}" \
  --location "${location}" \
  --subscription-id "${subscriptionId}" \
  --correlation-id "d009f5dd-dba8-4ac7-bac9-b54ef3a6671a"
