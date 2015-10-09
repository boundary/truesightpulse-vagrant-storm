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

2. Start the virtual machine using your Boundary API Token and Storm Version (optional):
```bash
$ API_TOKEN=<TrueSight Pulse API Token> STORM_VERSION=<0.9.3 (default)> SCALA_VERSION=<2.10> vagrant up <virtual machine name>
```
NOTE: Run `vagrant status` to list the name of the virtual machines.

3. Login to the virtual machine
```bash
$ vagrant ssh <virtual machine name>
```
