New-Cluster –Name ssdCluster –Node ssdnode1,ssdnode2,ssdnode3,ssdnode4 –NoStorage
New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\ClusSvc\Parameters" -Name S2D -PropertyType DWord -Value 1
Enable-ClusterStorageSpacesDirect -SkipEligibilityChecks -Autoconfig:1 -confirm:$false -PoolFriendlyName S2DPool -CacheState Disabled -verbose

New-Volume -FriendlyName "ResilDefault" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 20GB
New-Volume -FriendlyName "ResilParity" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 20GB -ResiliencySettingName Parity

$ClusterName = "ssdCluster"
$CSVCacheSize = 100 #Size in MB

Write-Output "Setting the CSV cache..."
(Get-Cluster $ClusterName).BlockCacheSize = $CSVCacheSize

$CSVCurrentCacheSize = (Get-Cluster $ClusterName).BlockCacheSize
Write-Output "$ClusterName CSV cache size: $CSVCurrentCacheSize MB"
