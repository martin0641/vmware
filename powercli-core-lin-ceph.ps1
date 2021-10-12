# ------vCenter Targeting Varibles and Connection Commands Below------
# This section insures that the PowerCLI PowerShell Modules are currently active. The pipe to Out-Null can be removed if you desire additional
# Console output.
Set-PowerCLIConfiguration -InvalidCertificateAction ignore
Get-Module -ListAvailable VMware* | Import-Module | Out-Null

# ------vSphere Targeting Variables tracked below------
$vCenterInstance = "vc01.lock.down"
$vCenterUser = "administrator@lock.down"
$vCenterPass = "123!@#qweQWE"

# This section logs on to the defined vCenter instance above
Connect-VIServer $vCenterInstance -User $vCenterUser -Password $vCenterPass -WarningAction SilentlyContinue 


######################################################-User-Definable Variables-In-This-Section-##########################################################################################


# ------Virtual Machine Targeting Variables tracked below------

# The Below Variables define the names of the virtual machines upon deployment, the target cluster, and the source template and customization specification inside of vCenter to use during
# the deployment of the VMs.
$Network = "10.1.6.0/24"
$FQDN = "omega.engineering"
$AdminVMName = "admin.ceph.$fqdn"
$AdminVMIP = "10.1.6.200"
$MonVMName = "mon01.ceph.$fqdn"
$MonVMIP = "10.1.6.201"
$OSD1VMName = "osd01.ceph.$fqdn"
$OSD1VMIP = "10.1.6.202"
$OSD2VMName = "osd02.ceph.$fqdn"
$OSD2VMIP = "10.1.6.203"
$OSD3VMName = "osd03.ceph.$fqdn"
$OSD3VMIP = "10.1.6.204"

$rootuser = "root"
$rootcred = "OMEGApass12!@"

$TargetCluster = Get-Cluster -Name "Omega-Core"
$SourceVMTemplate = Get-Template -Name "omega-ceph.linux.oracle.84"
$SourceCustomSpec = Get-OSCustomizationSpec -Name "Omega-Core-Lin"



# ------This section contains the commands for defining the IP and networking settings for the new virtual machines------

# Admin Node
$adminNetworkSettings = 'nmcli con add type ethernet ifname ens192 ip4 10.1.6.200/24 gw4 10.1.6.1 ipv6.method ignore'

# Monitor Node
$monNetworkSettings = 'nmcli con add type ethernet ifname ens192 ip4 10.1.6.201/24 gw4 10.1.6.1 ipv6.method ignore'

# OSD1 Node
$osd1NetworkSettings = 'nmcli con add type ethernet ifname ens192 ip4 10.1.6.202/24 gw4 10.1.6.1 ipv6.method ignore'

# OSD2 Node
$osd2NetworkSettings = 'nmcli con add type ethernet ifname ens192 ip4 10.1.6.203/24 gw4 10.1.6.1 ipv6.method ignore'

# OSD3 Node
$osd3NetworkSettings = 'nmcli con add type ethernet ifname ens192 ip4 10.1.6.204/24 gw4 10.1.6.1 ipv6.method ignore'

# ------This Section Contains the Scripts to be executed against the Admin VM------
#$InstallFSRole = 'Install-WindowsFeature -Name "FS-FileServer"' Set NFS

# The below block of code first creates a new folder and then creates a new SMB Share with rights given to the defined user or group.
#$NewFileShare = '$ShareLocation = "C:\shares";
#                 $FolderName = "oe.share.01";
#                 New-Item -Path $ShareLocation -Name $FolderName -ItemType "Directory";
#                 New-SmbShare -Name "oe.share.01" -Path "$ShareLocation\$FolderName" -FullAccess "omega.engineering\oe.admin"'
#
#
#########################################################################################################################################################################################



# Script Execution Occurs from this point down

# ------This Section Deploys the new VM(s) using a pre-built template and then applies a customization specification to it. It then waits for Provisioning To Finish------

Write-Verbose -Message "Deploying Virtual Machine with Name: [$AdminVMName] using Template: [$SourceVMTemplate] and Customization Specification: [$SourceCustomSpec] on Cluster: [$TargetCluster] and waiting for completion" -Verbose
 
New-VM -Name $AdminVMName -Template $SourceVMTemplate -ResourcePool $TargetCluster -OSCustomizationSpec $SourceCustomSpec

Write-Verbose -Message "Virtual Machine $AdminVMName Deployed. Powering On" -Verbose

Start-VM -VM $AdminVMName
#--
Write-Verbose -Message "Deploying Virtual Machine with Name: [$MonVMName] using Template: [$SourceVMTemplate] and Customization Specification: [$SourceCustomSpec] on Cluster: [$TargetCluster] and waiting for completion" -Verbose

New-VM -Name $MonVMName -Template $SourceVMTemplate -ResourcePool $TargetCluster -OSCustomizationSpec $SourceCustomSpec

Write-Verbose -Message "Virtual Machine $MonVMName Deployed. Powering On" -Verbose

Start-VM -VM $MonVMName
#--
Write-Verbose -Message "Deploying Virtual Machine with Name: [$OSD1VMName] using Template: [$SourceVMTemplate] and Customization Specification: [$SourceCustomSpec] on Cluster: [$TargetCluster] and waiting for completion" -Verbose

New-VM -Name $OSD1VMName -Template $SourceVMTemplate -ResourcePool $TargetCluster -OSCustomizationSpec $SourceCustomSpec

Write-Verbose -Message "Virtual Machine $OSD1VMName Deployed. Powering On" -Verbose

Start-VM -VM $OSD1VMName
#--
Write-Verbose -Message "Deploying Virtual Machine with Name: [$OSD2VMName] using Template: [$SourceVMTemplate] and Customization Specification: [$SourceCustomSpec] on Cluster: [$TargetCluster] and waiting for completion" -Verbose

New-VM -Name $OSD2VMName -Template $SourceVMTemplate -ResourcePool $TargetCluster -OSCustomizationSpec $SourceCustomSpec

Write-Verbose -Message "Virtual Machine $OSD2VMName Deployed. Powering On" -Verbose

Start-VM -VM $OSD2VMName
#--
Write-Verbose -Message "Deploying Virtual Machine with Name: [$OSD3VMName] using Template: [$SourceVMTemplate] and Customization Specification: [$SourceCustomSpec] on Cluster: [$TargetCluster] and waiting for completion" -Verbose

New-VM -Name $OSD3VMName -Template $SourceVMTemplate -ResourcePool $TargetCluster -OSCustomizationSpec $SourceCustomSpec

Write-Verbose -Message "Virtual Machine $OSD3VMName Deployed. Powering On" -Verbose

Start-VM -VM $OSD3VMName

# ------This Section Creates Controllers and Drives for OSD VMs------

New-HardDisk -VM [$OSD1VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD1VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD1VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD1VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD1VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD2VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD2VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD2VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD2VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD2VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD3VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD3VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD3VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD3VMName] -CapacityGB 10 -Persistence persistent
New-HardDisk -VM [$OSD3VMName] -CapacityGB 10 -Persistence persistent

# ------This Section Targets and Executes the Scripts on the New Domain Controller Guest VM------

Invoke-VMScript -ScriptText $adminNetworkSettings -VM $AdminVMName -GuestUser $rootuser -GuestPassword $rootcred
Invoke-VMScript -ScriptText $monNetworkSettings -VM $AdminVMName -GuestUser $rootuser -GuestPassword $rootcred
Invoke-VMScript -ScriptText $osd1NetworkSettings -VM $AdminVMName -GuestUser $rootuser -GuestPassword $rootcred
Invoke-VMScript -ScriptText $osd2NetworkSettings -VM $AdminVMName -GuestUser $rootuser -GuestPassword $rootcred
Invoke-VMScript -ScriptText $osd3NetworkSettings -VM $AdminVMName -GuestUser $rootuser -GuestPassword $rootcred

# We first verify that the guest customization has finished on on the new DC VM by using the below loops to look for the relevant events within vCenter. 


# NOTE - The below Sleep command is to help prevent situations where the post customization reboot is delayed slightly causing
# the Wait-Tools command to think everything is fine and carrying on with the script before all services are ready. Value can be adjusted for your environment. 
#Start-Sleep -Seconds 30

#Write-Verbose -Message "Waiting for VM $AdminVMName to complete post-customization reboot." -Verbose

#Wait-Tools -VM $AdminVMName -TimeoutSeconds 30


#Write-Verbose -Message "Environment Setup Complete" -Verbose

# End of Script