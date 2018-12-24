# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'hyperv'
VAGRANTFILE_API_VERSION = "2"

cluster = {
  "ssdnode1" => { :ip => "192.168.1.180", :cpus => 2, :mem => 4096 },
  "ssdnode2" => { :ip => "192.168.1.181", :cpus => 2, :mem => 4096 },
  "ssdnode3" => { :ip => "192.168.1.182", :cpus => 2, :mem => 4096 }
}
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "StefanScherer/windows_2019"
	config.vm.guest = :windows
    config.vm.communicator = "winrm"
    config.vm.boot_timeout = 600
    config.vm.graceful_halt_timeout = 600
	config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
    config.vm.synced_folder '.', '/vagrant', type: 'smb' , smb_username: "vagrant", smb_password: "vagrant", disabled: true
	cluster.each_with_index do |(hostname, info), index|
	  config.vm.define hostname do |cfg|
	    cfg.vm.network  "public_network", bridge: "External", ip: #{info[:ip]}
		cfg.vm.hostname = hostname
        cfg.vm.provider :hyperv do |hv|
			hv.vmname = hostname
			hv.memory =  info[:mem]
			hv.cpus = info[:cpus]
        end # end provider
	    cfg.vm.provision "shell", path: "scripts/windows/domain/joindomain.ps1", powershell_elevated_interactive: true 
	    cfg.vm.provision "shell", path: "scripts/windows/installChocolatey.cmd", powershell_elevated_interactive: true 
		cfg.vm.provision "shell", path: "scripts/windows/install-general.ps1", powershell_elevated_interactive: true 
		cfg.vm.provision :reload 
      end # end config
    end # end cluster
end