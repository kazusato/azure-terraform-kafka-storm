#!/usr/bin/env bash

rg_name=kakfa_storm_rg

vmlist=$(az vm list -g $rg_name --query '[].{name:name}' -o tsv)
for i in $vmlist
do
 echo "Starting VM $i"
 az vm start -g $rg_name -n $i --no-wait
done
