These steps need to be run after vagrant up is completed 

run from Hyper-V Host
0_EnableNestedVirtualization.ps1
1_BuildDisks.ps1

run from a cluster member
2_CleanDrives.ps1
3_Install_Ssd_Prereqs.ps1
4_CreateCluster.ps1
5_ValidateCluster.ps1