#!/usr/bin/env bash

#This file is only for Centos - The service was not getting started.

#Unpacking and installing Apache Storm from the zip file available with this repository.
unzip -o -q /vagrant/storm-installer-0.9.3-1.el6.x86_64.zip -d /vagrant/
sleep 20
rpm -ivh /vagrant/storm-installer-0.9.3-1.el6.x86_64/apache-storm-0.9.3-1.el6.x86_64.rpm  
rpm -ivh /vagrant/storm-installer-0.9.3-1.el6.x86_64/apache-storm-service-0.9.3-1.el6.x86_64.rpm 

#Starting storm services. Delay is required as it takes some time to startup.
/opt/storm/bin/storm nimbus &
sleep 30

/opt/storm/bin/storm supervisor &
sleep 30

/opt/storm/bin/storm ui &
sleep 30

#Stopping the firewall as the port-forwarding was blocked with firewall.
service iptables stop
chkconfig iptables off

