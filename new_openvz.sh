#!/bin/bash
ls /etc/pve/nodes/hwser01/qemu-server | awk -F. '{print $1}' > id.txt 
ls /etc/pve/nodes/hwser02/qemu-server | awk -F. '{print $1}' >> id.txt
ls /etc/pve/nodes/hwser04/qemu-server | awk -F. '{print $1}' >> id.txt
ls /etc/pve/nodes/hwser01/openvz | awk -F. '{print $1}'  >> id.txt
ls /etc/pve/nodes/hwser02/openvz | awk -F. '{print $1}'  >> id.txt
ls /etc/pve/nodes/hwser04/openvz | awk -F. '{print $1}'  >> id.txt
max=$(sort -n -k1 ./id.txt | tail -n 1)
NEXT=$(($max+1))

for ((a=199; a<=254; a++))
do
z=$(ping -c 4 192.168.2.$a | grep "0 received" | awk -F, '{print $2}')
y=" 0 received"
 if  [ "$z" == "$y" ]
 then
 NEXTIP="192.168.2.$a"
# echo $NEXTIP
# echo $NEXT
 break
 fi
done

vzctl create $NEXT --ostemplate /mnt/pve/NFS/template/cache/ubuntu-16.04-x86_64.tar.gz --config default_ubuntu
vzctl set $NEXT --hostname ubuntu$NEXT.xbs --save
vzctl set $NEXT --save --ipadd $NEXTIP
vzctl start $NEXT
