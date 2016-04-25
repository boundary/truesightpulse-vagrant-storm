# Explictly set to avoid warning message
Package
{
	allow_virtual => false,
}

node /^centos/ 
{
	file { 'bash_profile':
			path    => '/home/vagrant/.bash_profile',
			ensure  => file,
			source  => '/vagrant/manifests/bash_profile',
			before => Class['zookeeper']
	}
	
	exec { 'update-rpm-packages':
		command => '/usr/bin/yum update -y',
		timeout => 1800
	}

	package {'epel-release':
  		ensure => 'installed',
  		require => Exec['update-rpm-packages'],
	}
  
	# Used for unpacking storm for Centos.
	package{'unzip': 
		ensure => 'installed',
		require =>Exec['update-rpm-packages'],  
	}

	# Install Zookeeper at 127.0.0.1
	class { 'zookeeper':    
		service_name => 'zookeeper-server',
		install_java => true,
		java_package => 'java-1.8.0-openjdk',    
		manage_service         => true,
		manage_firewall        => false,
		require => Exec['update-rpm-packages']
	}
  
	#Creating zookeeper config file.
	file { 'zoo.cfg':
		path => '/opt/zookeeper/conf/zoo.cfg',
		ensure => file,
		source => '/opt/zookeeper/conf/zoo_sample.cfg'
	}

	# Configure TrueSight Pulse meter
	class { 'boundary':
		token => $::api_token
	}

}




node /ubuntu/ 
{
	file { 'bash_profile':
		path    => '/home/vagrant/.bash_profile',
		ensure  => file,
		source  => '/vagrant/manifests/bash_profile',
		before => Class['zookeeper']
	}

	exec { 'update-apt-packages':
		command => '/usr/bin/apt-get update -y',
	}

	# Install Zookeeper at 127.0.0.1
	class { 'zookeeper':
		client_ip => $::ipaddress_lo,
		require => Exec['update-apt-packages'],
		before => Class['storm']
	}

	# Configure a Storm components
	class {'storm':
		version => $::storm_version, 
		zookeeper_servers => [$::ipaddress_lo],
		require => Class['zookeeper']
	}

	include storm::install
	include storm::config

	include storm::nimbus
	include storm::ui
	include storm::supervisor

	# Configure TrueSight Pulse meter
	class { 'boundary':
		token => $::api_token,
	}

}


