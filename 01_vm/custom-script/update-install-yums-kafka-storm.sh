#!/usr/bin/env bash

yum update -y
yum install -y java-1.8.0-openjdk-devel nc
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y git2u
