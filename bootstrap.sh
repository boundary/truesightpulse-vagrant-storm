#!/usr/bin/env bash

unzip -o -q /vagrant/storm-installer-0.9.3-1.el6.x86_64.zip
rpm -ivh /vagrant/storm-installer-0.9.3-1.el6.x86_64/apache-storm-0.9.3-1.el6.x86_64.rpm  
rpm -ivh /vagrant/storm-installer-0.9.3-1.el6.x86_64/apache-storm-service-0.9.3-1.el6.x86_64.rpm 
chkconfig --level 345 storm-nimbus on
chkconfig --level 345 storm-ui on
chhconfig --level 345 storm-supervisor on
service storm-nimbus start
service storm-ui start
service storm-supervisor start

