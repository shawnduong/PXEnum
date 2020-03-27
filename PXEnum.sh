#!/bin/sh

# PXEnum

echo "--[ PXEnum ]--"
echo "* Version : v2.0 (2020.3.27)"
echo "* Source  : https://github.com/shawnduong/PXEnum"
echo "----------------------------------------------"
echo

# Basic Information

user=`whoami`          2> /dev/null # Current user
host=`uname -n`        2> /dev/null # Network node hostname
home=`echo $HOME`      2> /dev/null # User home directory
usid=`id -u`           2> /dev/null # User ID
gpid=`id -g`           2> /dev/null # Group ID
grps=`groups`          2> /dev/null # List all groups
knam=`uname -s`        2> /dev/null # Kernel name
krel=`uname -r`        2> /dev/null # Kernel release
kver=`uname -v`        2> /dev/null # Kernel version
arch=`uname -m`        2> /dev/null # Architecture
osys=`uname -o`        2> /dev/null # Operating System

echo "--[ Basic Information ]--"
echo "==> ABOUT THE USER"
echo "* Username       : $user"
echo "* Hostname       : $host"
echo "* Home Path      : $home"
echo "* EUID           : $usid"
echo "* EGID           : $gpid"
echo "* Groups         : $grps"
echo "==> ABOUT THE SYSTEM"
echo "* Kernel Name    : $knam"
echo "* Kernel Release : $krel"
echo "* kernel Version : $kver"
echo "* Architecture   : $arch"
echo "* OS Name        : $osys"
echo "----------------------------------------------"
echo

# Hardware Information

prdfmly=`cat /sys/class/dmi/id/product_family`  2> /dev/null # Product family
prdname=`cat /sys/class/dmi/id/product_name`    2> /dev/null # Product name
prdvers=`cat /sys/class/dmi/id/product_version` 2> /dev/null # Product Version

# CPUs and bugs
cpubugs=`
	grep "model name\|bugs" /proc/cpuinfo |
	awk -F ':' '{print "*",substr($2,2)}'
	` 2> /dev/null

meminfo=`grep "Mem" /proc/meminfo` 2> /dev/null # Memory information

# Total memory in kB
memtotl=`
	grep "MemTotal:" <<< "$meminfo" |
	awk -F ' ' '{print $(NF-1)}'
	` 2> /dev/null

# Available memory in kB
memavbl=`
	grep "MemAvailable" <<< "$meminfo" |
	awk -F ' ' '{print $(NF-1)}'
	` 2> /dev/null

# Free memory in kB
memfree=`
	grep "MemFree:" <<< "$meminfo" |
	awk -F ' ' '{print $(NF-1)}'
	` 2> /dev/null

echo "--[ Hardware Information ]--"
echo "==> Product"
echo "* Product Family  : $prdfmly"
echo "* Product Name    : $prdname"
echo "* Product Version : $prdvers"
echo "==> CPUs and Bugs"
echo "$cpubugs"
echo "==> Memory"
echo "* RAM Total      : $memtotl kB"
echo "* RAM Available  : $memavbl kB"
echo "* RAM Free       : $memfree kB"
echo "----------------------------------------------"
echo

# BIOS Information

biosvend=`cat /sys/class/dmi/id/bios_vendor`  2> /dev/null # Vendor
biosdate=`cat /sys/class/dmi/id/bios_date`    2> /dev/null # Date
biosvers=`cat /sys/class/dmi/id/bios_version` 2> /dev/null # Version

echo "--[ BIOS Information ]--"
echo "* BIOS Vendor  : $biosvend"
echo "* BIOS Date    : $biosdate"
echo "* BIOS Version : $biosvers"
echo "----------------------------------------------"
echo

# Users and Groups

# Sorted list of all users
auser=`
	printf "* %-24s %8s %8s   %s\n" "(Shell)" "(GID)" "(UID)" "(User)"          ;
	awk -F ':' '{printf "* %-24s %8s %8s   %s\n", $NF, $3, $4, $1}' /etc/passwd |
	sort
	` 2> /dev/null

# Sorted list of users with shells
suser=`
	printf "* %-24s %s\n" "(Shell)" "(User)"      ;
	grep -v "/usr/bin/nologin" /etc/passwd        |
	awk -F ':' '{printf "* %-24s %s\n", $NF, $1}' |
	sort
	` 2> /dev/null

# Sorted list of users with home directories
huser=`
	printf "* %-24s %s\n" "(Home Directory)" "User"   ;
	grep -v ":/:" /etc/passwd                         |
	awk -F ':' '{printf "* %-24s %s\n", $(NF-1), $1}' |
	sort
	` 2> /dev/null

# Sorted list of groups
grups=`
	printf "* %-8s %s\n" "(GID)" "(Group)"                 ;
	awk -F ':' '{printf "* %-8s %s\n", $3, $1}' /etc/group |
	sort -V
	` 2> /dev/null

echo "--[ Users and Groups ]--"
echo "==> Users"
echo "$auser"
echo "==> Users with login shells"
echo "$suser"
echo "==> Users with home directories"
echo "$huser"
echo "==> Groups"
echo "$grups"
echo "----------------------------------------------"
echo

# Network Information

ipdata=`ip -o link show` # IP data.

# Interfaces
ifaces=`
	printf "* %-16s %s\n" "(Interface)" "(Flags)"      ;
	awk -F ' ' '{printf "* %-16s %s\n", \
		substr($2,1,length($2)-1), $3}'  <<< "$ipdata" |
	sort
	` 2> /dev/null

# MAC addresses
maddrs=`
	printf "* %-16s %s\n" "(Interface)" "(MAC Address)"    ;
	awk -F ' ' '{printf "* %-16s %s\n", \
		substr($2,1,length($2)-1), $(NF-2)}' <<< "$ipdata" |
	sort
	` 2> /dev/null

# IP addresses
iaddrs=`
	printf "* %-16s %s\n" "(Interface)" "(IP Address)" ;
	ip address                                         |
	grep "inet "                                       |
	awk -F ' ' '{printf "* %-16s %s\n", $NF, $2}'      ;
	printf "* %-16s %s\n" "(Public)" "(IP Address)"    ;
	printf "* %-16s " "Public"                         ;
	dig +short myip.opendns.com @resolver1.opendns.com ;
	` 2> /dev/null

# Open ports
oports=`
	printf "* %-8s %-24s %s\n" "(Type)" "(Address)" "(PID/Program)" ;
	netstat -tulpn 2> /dev/null                                     |
	grep "LISTEN"                                                   |
	awk -F ' ' '{printf "* %-8s %-24s %s\n", $1, $4, $NF}'
	` 2> /dev/null

echo "--[ Network Information ]--"
echo "==> Interfaces"
echo "$ifaces"
echo "==> MAC Addresses"
echo "$maddrs"
echo "==> IP Addresses"
echo "$iaddrs"
echo "==> Open Ports"
echo "$oports"
echo "----------------------------------------------"
echo

# Activity

# Current users
currusers=`
	printf "* %-12s %-6s %-16s %-8s %-8s %s\n" \
		"(Username)" "(Term)" "(IP Address)" "(Login)" "(Idle)" "(Current Activity)" ;
	w -i                                                                             |
	tail +3                                                                          |
	awk -F ' ' '{printf "* %-12s %-6s %-16s %-8s %-8s %s\n", \
		$1, $2, $3, $4, $5, $NF}'                                                    |
	sort
	` 2> /dev/null

# Current processes
currprocs=`
	printf "* %-12s %-8s %s\n" "(Username)" "(PID)" "(Process)" ;
	ps -aux                                                     |
	tail +2                                                     |
	awk -F ' ' '{printf "* %-12s %-8s %s\n", $1, $2, $11}'      |
	sort -V
	` 2> /dev/null

# Active services
srvactive=`
	systemctl --type=service --state=active |
	grep "active "                          |
	awk -F ' ' '{print "*",$1}'             |
	sort
	` 2> /dev/null

# Running services
srvrunnin=`
	systemctl --type=service --state=running |
	grep "running"                           |
	awk -F ' ' '{print "*",$1}'              |
	sort
	` 2> /dev/null

echo "--[ Activity ]--"
echo "==> Currently Online Users"
echo "$currusers"
echo "==> Currently Running Processes"
echo "$currprocs"
echo "==> Active Services"
echo "$srvactive"
echo "==> Running Services"
echo "$srvrunnin"
echo "----------------------------------------------"
echo

# Timers

# Sorted list of timers
timers=`
	printf "* %-32s %s\n" "(Timer)" "(Service)"        ;
	systemctl list-timers                              |
	grep ".*\.timer"                                   |
	awk -F ' ' '{printf "* %-32s %s\n", $(NF-1), $NF}' |
	sort
	` 2> /dev/null

echo "--[ Timers ]--"
echo "$timers"
echo "----------------------------------------------"
echo

# /etc/shadow Permissions

shadow=`ls -l /etc/shadow`                     2> /dev/null # Shadow dump
permis=`awk -F ' ' '{print $1}' <<< "$shadow"` 2> /dev/null # Permissions
sowner=`awk -F ' ' '{print $3}' <<< "$shadow"` 2> /dev/null # Owner
sgroup=`awk -F ' ' '{print $4}' <<< "$shadow"` 2> /dev/null # Group

echo "--[ /etc/shadow Permissions ]--"
echo "* Access : $permis"
echo "* Owner  : $sowner"
echo "* Group  : $sgroup"
echo "----------------------------------------------"
echo

# /etc/sudoers Permissions

sudoers=`ls -l /etc/sudoers`                     2> /dev/null # Sudoers dump
superms=`awk -F ' ' '{print $1}' <<< "$sudoers"` 2> /dev/null # Permissions
suowner=`awk -F ' ' '{print $3}' <<< "$sudoers"` 2> /dev/null # Owner
sugroup=`awk -F ' ' '{print $4}' <<< "$sudoers"` 2> /dev/null # Group

echo "--[ /etc/sudoers Permissions ]--"
echo "* Access : $superms"
echo "* Owner  : $suowner"
echo "* Group  : $sugroup"
echo "----------------------------------------------"
echo

# Possible SUIDs

# SUID files
suids=`
	find / -perm /6000 2> /dev/null |
	awk '{print "*",$0}'
	` 2> /dev/null

echo "--[ Possible SUIDs ]--"
echo "$suids"
echo "----------------------------------------------"
echo

# sudo History

# Read sudo history from bash history
shist=`
	grep "sudo " ~/.bash_history 2> /dev/null |
	awk '{print "*",$0}'
	` 2> /dev/null

echo "--[ sudo History ]--"
echo "$shist"
echo "----------------------------------------------"
echo

# SSH Keys

# Find SSH keys in home directories
sshkeys=`
	ls /home/*/.ssh/*.rsa /home/*/.ssh/*.pub \
		/root/.ssh/*.rsa /root/.ssh/*.pub 2> /dev/null |
	awk '{print "*",$0}'
	` 2> /dev/null

echo "--[ SSH Keys ]--"
echo "$sshkeys"
echo "----------------------------------------------"
echo

# Versions

# Bash
vbash=`
	bash --version |
	head -1        |
	awk -F ' ' '{printf $4}'
	` 2> /dev/null

# sudo
vsudo=`
	sudo --version |
	head -1        |
	awk -F ' ' '{printf $3}'
	` 2> /dev/null

# GCC
vrgcc=`
	gcc --version |
	head -1       |
	awk -F ' ' '{printf $NF}'
	` 2> /dev/null

# Python 2
vpyt2=`
	python2 --version 2>&1 |
	awk -F ' ' '{print $2}'
	` 2> /dev/null

# Python3
vpyt3=`
	python3 --version |
	awk -F ' ' '{print $2}'
	` 2> /dev/null

# Java
vjava=`
	java --version |
	head -1        |
	awk -F ' ' '{print $2}'
	` 2> /dev/null

# cURL
vcurl=`
	curl --version |
	head -1        |
	awk -F ' ' '{print $2}'
	` 2> /dev/null

# wget
vwget=`
	wget --version |
	head -1        |
	awk -F ' ' '{print $3}'
	` 2> /dev/null

# Ruby
vruby=`
	ruby --version |
	awk -F ' ' '{print $2}'
	` 2> /dev/null

echo "--[ Versions ]--"
echo "* Bash     : $vbash"
echo "* sudo     : $vsudo"
echo "* GCC      : $vrgcc"
echo "* Python 2 : $vpyt2"
echo "* Python 3 : $vpyt3"
echo "* Java     : $vjava"
echo "* cURL     : $vcurl"
echo "* wget     : $vwget"
echo "* Ruby     : $vruby"
echo "----------------------------------------------"
echo
