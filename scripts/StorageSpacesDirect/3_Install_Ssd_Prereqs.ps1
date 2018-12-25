$ServerList = "ssdnode1", "ssdnode2", "ssdnode3", "ssdnode4"
Invoke-Command ($ServerList) {
Get-NetAdapterBinding -ComponentID 'ms_tcpip6' | disable-NetAdapterBinding -ComponentID ms_tcpip6 -PassThru
}

$vmlist = @("ssdnode2","ssdnode3","ssdnode4")
Invoke-Command -ComputerName $vmlist -ScriptBlock {Install-WindowsFeature -Name "Hyper-V", "Failover-Clustering", "Data-Center-Bridging", "RSAT-Clustering-PowerShell", "Hyper-V-PowerShell", "FS-FileServer"}
Invoke-Command -ComputerName $vmlist -ScriptBlock {Restart-computer -force}
$vmlist = @("ssdnode1")
Invoke-Command -ComputerName $vmlist -ScriptBlock {Install-WindowsFeature -Name "Hyper-V", "Failover-Clustering", "Data-Center-Bridging", "RSAT-Clustering-PowerShell", "Hyper-V-PowerShell", "FS-FileServer"}
Invoke-Command -ComputerName $vmlist -ScriptBlock {Restart-computer -force}

