#!/usr/bin/env bash
# Purpose: Install and Initialize CEPH Monitor Node
#          Must run as root
# Author: Chris Martin <martin0641@gmail.com>
# --------------------------------------

# Variables
# monnumber="USER INPUT"
printf "All values should be entered without the quotes used in the examples"
read -p "Enter the intended number of Monitor Nodes '1': " monnumber
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# monhostname="USER INPUT"
read -p "Enter Initial Monitor Node Hostname without FQDN 'monitor01': " monhostname
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# fqdn="USER INPUT"
read -p "Enter FQDN without Hostname 'foo.bar':: " fqdn
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# osdhosts="USER INPUT"
read -p "Enter the number of OSD hosts":: " osdhosts
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# adminuser="USER INPUT"
read -p "Enter admin username (not root):: " adminuser
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# subnet="USER INPUT"
read -p "Enter Broadcast Address with CIDR "192.168.1.0/24":: " broadcast
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
