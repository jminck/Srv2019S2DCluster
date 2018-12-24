New-Cluster –Name ssdCluster –Node ssdnode1,ssdnode2,ssdnode3 –NoStorage
Enable-ClusterStorageSpacesDirect –CimSession ssdCluster

New-Volume -FriendlyName "Volume1" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 20GB

$ClusterName = "ssdCluster"
$CSVCacheSize = 100 #Size in MB

Write-Output "Setting the CSV cache..."
(Get-Cluster $ClusterName).BlockCacheSize = $CSVCacheSize

$CSVCurrentCacheSize = (Get-Cluster $ClusterName).BlockCacheSize
Write-Output "$ClusterName CSV cache size: $CSVCurrentCacheSize MB"
