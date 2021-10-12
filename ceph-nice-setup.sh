#!/usr/bin/env bash
# Purpose: Install and Initialize CEPH Monitor Node
#          Must run as root
# Author: Chris Martin <martin0641@gmail.com>
# --------------------------------------

# UserInputVariables
# --------------------------------------
# monnumber="USER INPUT"
printf "All values should be entered without the quotes used in the examples\n"
printf "This script is currently setup to use a /24 CIDR\n"
#read -p "Enter the intended number of Monitor Nodes '1': " monnumber
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# monhostname="USER INPUT"
#read -p "Enter Initial Monitor Node Hostname without FQDN or numbering 'monitor' or 'monhost' etc.: " monhostname
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# fqdn="USER INPUT"
#read -p "Enter FQDN without Hostname 'foo.bar': " fqdn
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# osdhosts="USER INPUT"
#read -p "Enter the number of OSD hosts: " osdhosts
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# adminuser="USER INPUT"
#read -p "Enter admin username (not root): " adminuser
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# subnet="USER INPUT"
#read -p "Enter Broadcast Address with out CIDR "192.168.1.0": " subnetbroadcast
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# subnetcidr="USER INPUT"
#read -p "Enter CIDR '26' '20' '16' etc.: " subnetcidr
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# monipstart="USER INPUT"
#read -p "Enter Initial Monitor IP without CIDR "192.168.10.1": " monipstart
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# osdipstart="USER INPUT"
#read -p "Enter Initial OSD Host IP without CIDR "192.168.1.20": " osdipstart
#read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# !UserInputVariables
# --------------------------------------

# DeclaredVariables
# --------------------------------------
monnumber=5
monhostname=montest
fqdn=foo.bar
osdhosts=5
adminuser=cephadmin
subnetbroadcast=192.168.5.0
subnetcidr=24
monipstart=192.168.5.10
osdipstart=192.168.5.20


# !DeclaredVariables
# --------------------------------------
monhostcount=$monnumber
monipeinitialoctet4="${monipstart##*.}"
monipupper="$monipeinitialoctet4+($monnumber-1)"

if monipeinitialoctet4 >= 1 $$ <= 9 
then
    monipprefix=${monipstart%?}
        elif $monipeinitialoctet4 >= 10 $$ <= 99 
        then
            monipprefix=${monipstart%??}
        elif $monipeinitialoctet4 >= 100 $$ <= 254 
        then
            monipprefix=${monipstart%???}
else printf Invalid IP           

printf $monhostname$monipeinitialoctet4.$fqdn     $monipstart
while $monhostcount > 0; do
    monhostcount=$monhostcount-1
    monipenum=$monipeinitialoctet4+1
    printf $monhostname$monipenum.$fqdn     $monipprefix$monipenum
    monhostip-$monipeinitialoctet4=$monipeinitialoctet4+1
    monhostname-$monhostname=$monipeinitialoctet4+1
    monhostfqdn-$monhostfqdn=$monhostname$monhostip-$monipeinitialoctet4.$fqdn
done

# !CalculatedVariables
# --------------------------------------

# Input Processing
# --------------------------------------


END=$monnumber
for ((i=monipeinitialoctet4;i<=END;i++)); do
    echo $monhostname$i.$fqdn
    echo ${192.168.10.1%??}]
    monipeinitialoctet4=$monipeinitialoctet4+1
done




# Functions
# --------------------------------------
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}
# !Functions
# --------------------------------------
