le API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

#Main Block.
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	# Configure additional CPUs and Memory
	config.vm.provider "virtualbox" do |v|
	
		v.memory = 2048
		v.cpus = 2
	end

	# Port-forwarding for guest port 8080.(This is were the Storm UI service will be running)
	config.vm.network "forwarded_port", guest: 8080, host: 8080



	
	# Centos-6.6 specific configuration
	config.vm.define "centos-6.6", autostart: false do |v|
		v.vm.box = "puppetlabs/centos-6.6-64-puppet"
		v.vm.box_version = "1.0.1"
		v.vm.hostname = "centos-6-6"    
	    
		config.vm.provision :shell do |shell|
			shell.inline = "puppet module install pennycoders-zookeeper;                   
					puppet module install boundary-boundary;
					exit 0"
		end
	    
		# Needed to override to change the default outside-in ordering.
		config.vm.provision "puppet" do |puppet|
			puppet.manifests_path = "manifests"
		        puppet.manifest_file  = "site.pp"
		        puppet.facter = {
		           "api_token" => ENV["API_TOKEN"],
		           "storm_version" => ENV["STORM_VERSION"] ||= "0.9.3"
		        }
		end
	    
		v.vm.provision "shell", path: "bootstrap.sh"
	end



	
	# Centos-7.0 specific configuration.
	config.vm.define "centos-7.0", autostart: false do |v|
		v.vm.box = "puppetlabs/centos-6.6-64-puppet"
		v.vm.box_version = "1.0.1"
		v.vm.hostname = "centos-6-6"    
		    
		config.vm.provision :shell do |shell|
			shell.inline = "puppet module install pennycoders-zookeeper;                   
					puppet module install boundary-boundary;
					exit 0"
		end
		    
		# Needed to override to change the default outside-in ordering.
		config.vm.provision "puppet" do |puppet|
			puppet.manifests_path = "manifests"
			puppet.manifest_file  = "site.pp"
			puppet.facter = {
				"api_token" => ENV["API_TOKEN"],
				"storm_version" => ENV["STORM_VERSION"] ||= "0.9.3"
			}
		end

		v.vm.provision "shell", path: "bootstrap.sh"
	end


	
	
	# Ubuntu-12.04 specific configuration.
	config.vm.define "ubuntu-12.04", autostart: false do |v|
		v.vm.box = "puppetlabs/ubuntu-12.04-64-puppet"
		v.vm.box_version = "1.0.1"
		v.vm.hostname = "ubuntu-12-04"
		v.vm.provision "shell", inline: "sed -i 's/127.0.1.1/127.0.0.1/' /etc/hosts"
		
		# Installing required puppet modules.
		config.vm.provision :shell do |shell|
			shell.inline = "puppet module install puppetlabs-stdlib;
					puppet module install puppetlabs-apt;
					puppet module install richardc-datacat;
					puppet module install deric-zookeeper;
					puppet module install puppetlabs-java;
					puppet module install kupferk-storm;
					puppet module install boundary-boundary;
					exit 0"
		end
		
		# Needed to override to change the default outside-in ordering.
		config.vm.provision "puppet" do |puppet|
			puppet.manifests_path = "manifests"
			puppet.manifest_file  = "site.pp"
			puppet.facter = {
				"api_token" => ENV["API_TOKEN"],
				"storm_version" => ENV["STORM_VERSION"] ||= "0.9.3"
			}
		end
	end


	
	
	# Ubuntu-14.04 specific configuration.
	config.vm.define "ubuntu-14.04", autostart: false do |v|
		v.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
		v.vm.box_version = "1.0.1"
		v.vm.hostname = "ubuntu-14-04"
		v.vm.provision "shell", inline: "sed -i 's/127.0.1.1/127.0.0.1/' /etc/hosts"
			
		# Installing required puppet modules.
		config.vm.provision :shell do |shell|
			shell.inline = "puppet module install puppetlabs-stdlib;
					puppet module install puppetlabs-apt;
					puppet module install richardc-datacat;
					puppet module install deric-zookeeper;
					puppet module install puppetlabs-java;
					puppet module install kupferk-storm;
					puppet module install boundary-boundary;
					exit 0"
		end
		    
		# Needed to override to change the default outside-in ordering.
		config.vm.provision "puppet" do |puppet|
			puppet.manifests_path = "manifests"
			puppet.manifest_file  = "site.pp"
			puppet.facter = {
				"api_token" => ENV["API_TOKEN"],
				"storm_version" => ENV["STORM_VERSION"] ||= "0.9.3"
			}
		end
	end
end


