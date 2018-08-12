#!/usr/bin/env bash

TF_PROJ_NAME=kafka-storm
RBAC_ACCOUNT_NAME=tf-contributor-${TF_PROJ_NAME}

az ad sp delete --id $(az ad sp list --display-name ${RBAC_ACCOUNT_NAME} --query '[].appId' -o tsv)
