$vmlist = @("ssdnode1","ssdnode2","ssdnode3")
foreach ($vm in $vmlist)
{
	Stop-VM $vm
	Set-VMProcessor -VMName $vm -ExposeVirtualizationExtensions $true
	Start-VM $vm
}