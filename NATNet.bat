@ECHO OFF

cd /D D:\Virtualbox

VBoxManage natnetwork add --netname natnet1 --network "192.168.100.0/24" --enable --dhcp on
VBoxManage natnetwork modify --netname natnet1 --port-forward-4 "HTTPS:tcp:[]:443:[192.168.100.100]:443"
VBoxManage natnetwork modify --netname natnet1 --port-forward-4 "HTTP:tcp:[]:80:[192.168.100.100]:80"
VBoxManage natnetwork modify --netname natnet1 --port-forward-4 "ssh:tcp:[]:22:[192.168.100.100]:22"
VBoxManage natnetwork modify --netname natnet1 --port-forward-4 "mysql:tcp:[]:3306:[192.168.100.100]:3306"

PAUSE