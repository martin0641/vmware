# DISCLAIMER: There are no warranties or support provided for this script. Use at you're own discretion. Andy Syrewicze and/or Altaro Software are not liable for any
# damage or problems that misuse of this script may cause.

# Script is Written by Andy Syrewicze - Tech. Evangelist with Altaro Software and is free to use as needed within your organization.

# This Script is Primarily a Deployment Script. It will first deploy a template from your vSphere environment, apply a customization specification, and then install and configure Active
# Directory Domain Services on one VM, and the File Services on another. Additionally the file server will be a member of the newly deployed VM, a new administrative user account will
# be created and a file share will be provisioned on the new file server. 

# Script was designed for PowerShell/PowerCLI Beginners who have not yet begun to work with functions and more advanced PowerShell features. 
# The below script first lists all user definable varibles and then executes the script's actions in an easy to follow sequential order. 

# Assumptions
# - You Have vCenter inside your environment
# - You have pre-configured templates and customization specifications inside of vCenter
# - Your PowerShell execution policy allows the execution of this script

# ------vCenter Targeting Varibles and Connection Commands Below------
# This section insures that the PowerCLI PowerShell Modules are currently active. The pipe to Out-Null can be removed if you desire additional
# Console output.
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
$TargetCluster = Get-Cluster -Name "Omega-Core"



# The below block of code first creates a new folder and then creates a new SMB Share with rights given to the defined user or group.


#########################################################################################################################################################################################



# Script Execution Occurs from this point down

# ------This Section Deploys the new VM(s) using a pre-built template and then applies a customization specification to it. It then waits for Provisioning To Finish------

Write-Verbose -Message "Stopping Virtual Machine with Name: [$AdminVMName] on Cluster: [$TargetCluster]" -Verbose
Stop-VM -VM $AdminVMName -Kill -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Deleting Virtual Machine with Name: [$AdminVMName] on Cluster: [$TargetCluster]" -Verbose
Remove-VM -VM $AdminVMName -DeletePermanently -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Virtual Machine $AdminVMName Deleted." -Verbose
Start-Sleep -Seconds 1

Write-Verbose -Message "Stopping Virtual Machine with Name: [$MonVMName] on Cluster: [$TargetCluster]" -Verbose
Stop-VM -VM $MonVMName -Kill -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Deleting Virtual Machine with Name: [$MonVMName] on Cluster: [$TargetCluster]" -Verbose
Remove-VM -VM $MonVMName -DeletePermanently -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Virtual Machine $MonVMName Deleted." -Verbose
Start-Sleep -Seconds 1

Write-Verbose -Message "Stopping Virtual Machine with Name: [$OSD1VMName] on Cluster: [$TargetCluster]" -Verbose
Stop-VM -VM $OSD1VMName -Kill -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Deleting Virtual Machine with Name: [$OSD1VMName] on Cluster: [$TargetCluster]" -Verbose
Remove-VM -VM $OSD1VMName -DeletePermanently -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Virtual Machine $OSD1VMName Deleted." -Verbose
Start-Sleep -Seconds 1

Write-Verbose -Message "Stopping Virtual Machine with Name: [$OSD2VMName] on Cluster: [$TargetCluster]" -Verbose
Stop-VM -VM $OSD2VMName -Kill -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Deleting Virtual Machine with Name: [$OSD2VMName] on Cluster: [$TargetCluster]" -Verbose
Remove-VM -VM $OSD2VMName -DeletePermanently -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Virtual Machine $OSD2VMName Deleted." -Verbose
Start-Sleep -Seconds 1

Write-Verbose -Message "Stopping Virtual Machine with Name: [$OSD3VMName] on Cluster: [$TargetCluster]" -Verbose
Stop-VM -VM $OSD3VMName -Kill -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Deleting Virtual Machine with Name: [$OSD3VMName] on Cluster: [$TargetCluster]" -Verbose
Remove-VM -VM $OSD3VMName -DeletePermanently -Confirm:$false
Start-Sleep -Seconds 4
Write-Verbose -Message "Virtual Machine $OSD3VMName Deleted." -Verbose
Start-Sleep -Seconds 1

# NOTE - Sleep for future uses. 
# Start-Sleep -Seconds 8

Write-Verbose -Message "Environment Deletion Complete" -Verbose

# End of Script