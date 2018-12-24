$vmlist = @("ssdnode1","ssdnode2","ssdnode3")
foreach ($vm in $vmlist)
{
	Stop-VM $vm -force
	Set-VMProcessor -VMName $vm -ExposeVirtualizationExtensions $true
	Start-VM $vm
}