#!/usr/bin/env bash
# Purpose: Install and Initialize CEPH Monitor Node
#          Must run as root
# Author: Chris Martin <martin0641@gmail.com>
# --------------------------------------

# DeclaredVariables
# --------------------------------------
monhostname=mon01
monhostip1=10.99.0.10
fqdn=vcinity.lab
osdhostip1=10.99.0.11
osdhostname1=osd1
osdhostiip2=10.99.0.12
osdhostname2=osd2
osdhostip3=10.99.0.13
osdhostname3=osd3
adminuser=cephadmin
subnetbroadcast=10.99.0.0
subnetcidr=24
gateway=10.99.0.1


# !DeclaredVariables
# --------------------------------------

# Input Processing
# --------------------------------------


END=$monnumber
for ((i=monipeinitialoctet4;i<=END;i++)); do
    echo $monhostname$i.$fqdn
    echo ${192.168.10.1%??}]
    monipeinitialoctet4=$monipeinitialoctet4+1
done