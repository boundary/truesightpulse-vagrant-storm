# TrueSight Pulse Vagrant Storm 

Configures a virtual machine with a Storm instance for testing TrueSight Pulse Plugin for Storm.

## Prerequistes

- Vagrant 1.72. or later, download [here](https://www.vagrantup.com/downloads.html)
- Virtual Box 4.3.26 or later, download [here](https://www.virtualbox.org/wiki/Downloads)
- git 1.7 or later

## Installation

Prior to installation you need to obtain in your Boundary API Token.

1. Clone the GitHub Repository:
```bash
$ git clone https://github.com/boundary/truesightpulse-vagrant-storm
```

2. Start the virtual machine using your TrueSight Pulse API Token and Storm Version (optional):
```bash
$ API_TOKEN=<TrueSight Pulse API Token> STORM_VERSION=<0.9.3 (default)> vagrant up <virtual machine name>
```
NOTE: Run `vagrant status` to list the name of the virtual machines.

3. Login to the virtual machine
```bash
$ vagrant ssh <virtual machine name>
```

## Note
All the metrics will not be shown once the vagrant is up. You will need to run topologies to see all the metrices.
Storm installation provides few examples. Use below command to start a topology. Storm is installed at /opt/storm

1. Starting the topology.
```bash
$ bin/storm jar examples/storm-starter/storm-starter-topologies-0.9.3.jar storm.starter.ExclamationTopology One
```

2. Stopping the topology.
```bash
$ bin/storm kill One
```

3. Details of the storm instance can be found in the portal -> http://localhost:8080


## Known Issues

1. Bounday-meter puppet module fails with Centos-7.0 (You will need to install boundary-meter manually).
2. Firewall blocks vagrant port-forwarding at few occasions. we may need to stop firewall to make it work.
