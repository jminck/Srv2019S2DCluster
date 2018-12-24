#this script creates and attaches data disks to each of the cluster meembers for use in the storage pool

$nodes = 3
$disks = 5
$vmbasename = "ssdnode"
$diskcount = 0

for ($node = 1; $node -le $nodes; $node++)
	{
		$vhdpath = ".\.vagrant\machines\ssdnode" + $node + "\hyperv\Virtual Hard Disks"
		for ($disk = 1; $disk -le $disks ;$disk++ )
		{
			$vmname = $vmbasename + $node
		    $vhdfullpath = $vhdpath + "\" + $vmbasename + $node + "-" + $disk + ".vhdx"

            if (!(test-path $vhdfullpath)){	New-VHD -Path $vhdfullpath -SizeBytes 10GB }
            add-VMHardDiskDrive -VMName $vmname -ControllerType SCSI -ControllerNumber 0 -Path $vhdfullpath
            start-sleep 1
            $diskcount++
		}
	}
