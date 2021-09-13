## populate things manually (this would be before the rest of the code that actually does the deployment)
## name of template to use
## $strSourceTemplate = "win2012R2Template"
## name for new VM
$strNewVMName = "ceph3"
## name of destination cluster
## $strSomeCluster = "bigCluster2"
## name of destination datastore cluster
$strDestDStore = "SSD"
## storage format to use for new VM
$strStorageFormat = "thin"
## name of destination VM inventory folder
## $strDestinationFolder = "WinVMs"
## name of OSCustSpec to use
## $strOurCustSpecName = "ubuntu"
## notes to add to VM
$strVMNotes = "CEPH VM for Scale"
## name of virtual portgroup for this VM
$strSomePG = "VLAN-0006-NIX"
## new MAC addr to use
## $strNewMacAddr = "00:50:56:0f:08:04"
## Hostname or IP
$strHostIP = "192.168.1.251"

## make hashtable of values for new VM creation
$hshNewVMParams = @{
    ## Template = $strSourceTemplate
    Name = $strNewVMName
    ## default "Resources" resource pool, so as to put VM in desired cluster
    ##  ResourcePool = Get-Cluster $strSomeCluster | Get-ResourcePool -Name "Resources"
    VMHost = $strHostIP
    Datastore = $strDestDStore
    DiskStorageFormat = $strStorageFormat
    ## Location = Get-Folder $strDestinationFolder
    ## OSCustomizationSpec = Get-OSCustomizationSpec -Name $strOurCustSpecName
    Notes = $strVMNotes
} ## end hsh

## create new VM
$vmNewOne = New-VM @hshNewVMParams
## set NIC portgroup
$strSomePG = "VLAN-0006-NIX"
$vmNewOne | Get-NetworkAdapter | 
##  Set-NetworkAdapter -Type Vmxnet3 -Confirm:$False
##  Set-NetworkAdapter -NetworkName $strSomePG -Confirm:$False
    Set-NetworkAdapter -NetworkName $strSomePG -StartConnected 1 -Connected 1 -WakeOnLan 1 -Type Vmxnet3 -DistributedSwitch ESX-CORE -Confirm:$false
##  Set-NetworkAdapter -StartConnected:$true -Confirm:$false
## start the VM
## Start-VM -VM $vmNewOne