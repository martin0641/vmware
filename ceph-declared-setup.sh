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
rootpass='MDxControl!'

# !DeclaredVariables
# --------------------------------------

# Input Processing
# --------------------------------------

cat <<EOF >> /etc/yum.repos.d/ceph.repo
[ceph] 
name=Ceph packages for $basearch 
baseurl=https://download.ceph.com/rpm-pacific/el8/$basearch 
enabled=1 
priority=2 
gpgcheck=1 
gpgkey=https://download.ceph.com/keys/release.asc 
[ceph-noarch] 
name=Ceph noarch packages 
baseurl=https://download.ceph.com/rpm-pacific/el8/noarch
enabled=1 
priority=2 
gpgcheck=1 
gpgkey=https://download.ceph.com/keys/release.asc 
[ceph-source] 
name=Ceph source packages 
baseurl=https://download.ceph.com/rpm-pacific/el8/SRPMS 
enabled=0 
priority=2 
gpgcheck=1 
gpgkey=https://download.ceph.com/keys/release.asc
EOF

dnf install epel-release
dnf update

dnf install -y htop 