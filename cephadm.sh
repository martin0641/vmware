#!/usr/bin/env bash
# Purpose: Install and Initialize CEPH Monitor Node
#          Must run as root
# Author: Chris Martin <martin0641@gmail.com>
# --------------------------------------

# DeclaredVariables
# --------------------------------------
cephinstalldir=/opt/ceph
cephmon=127.0.0.1

cephadm
su -c 'rpm -Uvh https://download.ceph.com/rpm-16.2.6/el8/noarch/cephadm-16.2.6-0.el8.noarch.rpm'
mkdir /opt/ceph
cd $cephinstalldir
rpm --import 'https://download.ceph.com/keys/release.asc'
su -c 'rpm -Uvh https://download.ceph.com/rpm-16.2.6/el8/noarch/cephadm-16.2.6-0.el8.noarch.rpm'
cephadm pull
cephadm bootstrap --mon-ip $cephmon --allow-mismatched-release --cluster-network 10.1.6.0/24 --allow-fqdn-hostname


#curl --silent --remote-name --location https://github.com/ceph/ceph/raw/pacific/src/cephadm/cephadm
#chmod +x cephadm
#ln -s /root/cephadm /bin/cephadm

