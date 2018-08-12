#!/usr/bin/env bash

rg_name=kakfa_storm_rg

vmlist=$(az vm list -g $rg_name --query '[].{name:name}' -o tsv)
for i in $vmlist
do
 echo "Restarting VM $i"
 az vm restart -g $rg_name -n $i --no-wait
done
