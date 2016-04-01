# Explictly set to avoid warning message
Package {
  allow_virtual => false,
}

node /ubuntu/ {

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

# Separate the Cento 7.0 install until the boundary meter puppet package is fixed
node /^centos-7-0/ {
  file { 'bash_profile':
    path    => '/home/vagrant/.bash_profile',
    ensure  => file,
    source  => '/vagrant/manifests/bash_profile',
    before => Package['epel-release']
  }

  exec { 'update-rpm-packages':
    command => '/usr/bin/yum update -y',
    timeout => 1800
  }
  
  package{'unzip': 
    ensure => 'installed',
    require =>Exec['update-rpm-packages'],
    before => Class['java']
  }

  package {'epel-release':
    ensure => 'installed',
    require => Exec['update-rpm-packages'],
    before => Class['java']
  }

  class { 'java':
    distribution => 'jre',
    before => Class['zookeeper'],
    require => Exec['update-rpm-packages']
  }

  # Install Zookeeper at 127.0.0.1
  class { 'zookeeper':
    repo => 'cloudera',
    cdhver => '5',
    packages => ['zookeeper', 'zookeeper-server'],
    service_name => 'zookeeper-server',
    initialize_datastore => true,
    client_ip => $::ipaddress_lo,
    require => Exec['update-rpm-packages']
  }
}

node /^centos/ {

  file { 'bash_profile':
    path    => '/home/vagrant/.bash_profile',
    ensure  => file,
    source  => '/vagrant/manifests/bash_profile',
    before => Package['epel-release']
  }

  exec { 'update-rpm-packages':
    command => '/usr/bin/yum update -y',
    timeout => 1800
  }
  
  package{'unzip': 
    ensure => 'installed',
    require =>Exec['update-rpm-packages'],
    before => Class['java']
  }

  package {'epel-release':
    ensure => 'installed',
    require => Exec['update-rpm-packages'],
    before => Class['java']
  }

  class { 'java':
    distribution => 'jre',
    before => Class['zookeeper'],
    require => Exec['update-rpm-packages']
  }

  # Install Zookeeper at 127.0.0.1
  class { 'zookeeper':
    repo => 'cloudera',
    cdhver => '5',
    packages => ['zookeeper', 'zookeeper-server'],
    service_name => 'zookeeper-server',
    initialize_datastore => true,
    client_ip => $::ipaddress_lo,
    require => Exec['update-rpm-packages']
  }

  # Configure TrueSight Pulse meter
  class { 'boundary':
    token => $::api_token
  }

}

