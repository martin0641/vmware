#Connect-VIServer -Server 192.168.1.248
#administrator@lock.down
#123!@#qweQWE

New-VM -Name 'CEPH' -VMHost '192.168.1.251' -CoresPerSocket 1 -HardwareVersion vmx-19 -DiskStorageFormat Thin -Datastore 'SSD' -DiskGB 15,10,10,10,10,10,10 -MemoryGB 32 -NumCpu 16 -portgroup ESX-CORE 





-NetworkName 'VLAN-0006-NIX'