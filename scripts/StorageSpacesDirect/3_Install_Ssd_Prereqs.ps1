$vmlist = @("ssdnode1","ssdnode2","ssdnode3")
Invoke-Command -ComputerName $vmlist -ScriptBlock {Install-WindowsFeature -Name "Hyper-V", "Failover-Clustering", "Data-Center-Bridging", "RSAT-Clustering-PowerShell", "Hyper-V-PowerShell", "FS-FileServer"}
Invoke-Command -ComputerName $vmlist -ScriptBlock {Restart-computer}
