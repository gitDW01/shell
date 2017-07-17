#!/bin/bash
#скрипт запускается из корневой дирректории chef, первым параметром необходимо указать имя выбираемой для установки ОС
#Example: ./auto_openvz ubuntu 

case "$1" in
ubuntu)
knife bootstrap --run-list "recipe[proxmox::new_ubuntu_openvz]" hwser02.xbs.corp -P 12QWaszx > machine.txt
cat machine.txt | grep machine: | awk -F: '{print $2}' > machine1.txt
echo $(cat machine1.txt | tail -n 2) | tr -d '\r' >> /etc/hosts
cat /etc/hosts | tail -n 1 | awk -F" " '{print $2}' > machine3.txt
DESTINATION=$(cat machine3.txt)
knife bootstrap --run-list "recipe[proxmox::hosts]" $DESTINATION -P 12QWaszx
;;

centos)
knife bootstrap --run-list "recipe[proxmox::new_centos_openvz]" hwser02.xbs.corp -P 12QWaszx > machine.txt
cat machine.txt | grep machine: | awk -F: '{print $2}' > machine1.txt
echo $(cat machine1.txt | tail -n 2) | tr -d '\r' >> /etc/hosts
cat /etc/hosts | tail -n 1 | awk -F" " '{print $2}' > machine3.txt
DESTINATION=$(cat machine3.txt)
knife bootstrap --run-list "recipe[proxmox::hosts]" $DESTINATION -P 12QWaszx
;;

esac
