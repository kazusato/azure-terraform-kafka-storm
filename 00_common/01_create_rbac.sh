#!/usr/bin/env bash

TARGET_LOCATION=japanwest
TF_PROJ_NAME=kafka-storm
RBAC_ACCOUNT_NAME=tf-contributor-${TF_PROJ_NAME}
CUSTOM_SCRIPT_STORAGE_ACCOUNT=terraformworkstorage
CUSTOM_SCRIPT_STORAGE_ACCOUNT_RG=terraform-rg

# Azure account information
ACCOUNT_JSON=$(az account show --query "{subscriptionId:id, tenantId:tenantId}")
echo ${ACCOUNT_JSON}

export SUB_ID=$(echo ${ACCOUNT_JSON} | jq .subscriptionId -r)
export TENANT_ID=$(echo ${ACCOUNT_JSON} | jq .tenantId -r)

# Account for Terraform
RBAC_JSON=$(az ad sp create-for-rbac -n ${RBAC_ACCOUNT_NAME} --role="Contributor" --scopes="/subscriptions/${SUB_ID}")
echo ${RBAC_JSON}

export APP_ID=$(echo ${RBAC_JSON} | jq .appId -r)
export SP_NAME=$(echo ${RBAC_JSON} | jq .name -r)
export PASSWORD=$(echo ${RBAC_JSON} | jq .password -r)

# Storage account for Custom script
export CUSTOM_SCRIPT_STORAGE_ACCOUNT
export CUSTOM_SCRIPT_STORAGE_ACCESS_KEY=$(az storage account keys list -n ${CUSTOM_SCRIPT_STORAGE_ACCOUNT} \
 -g ${CUSTOM_SCRIPT_STORAGE_ACCOUNT_RG} --query '[?keyName==`key1`].{value:value}' -o tsv)
export CUSTOM_SCRIPT_STORAGE_BASE_URI=$(az storage account show -n ${CUSTOM_SCRIPT_STORAGE_ACCOUNT} \
 -g ${CUSTOM_SCRIPT_STORAGE_ACCOUNT_RG} --query 'primaryEndpoints.blob' -o tsv)

mkdir -p nogit
cat ZZ_azure_config.sh.template | envsubst | tee nogit/ZZ_azure_config.sh
