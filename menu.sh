#!/bin/bash
Yellow='\e[0;33m'
green='\e[32m'
RED='\033[0;31m'
NC='\033[0m'
BGBLUE='\e[1;44m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0;37m'
# ==========================================
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

BURIQ () {
    curl -sS https://raw.githubusercontent.com/Diyserver/new/main/authipvps > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/Diyserver/new/main/authipvps | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/Diyserver/new/main/authipvps | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION

if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
echo -ne
else
red "Permission Denied!"
exit 0
fi
clear
echo -e ""
# DNS Patch
tipeos2=$(uname -m)
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
downloadsize=$(($download/1073741824))
# Upload
upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
uploadsize=$(($upload/1073741824))
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
# Shell Version
shellversion=""
shellversion=Bash
shellversion+=" Version" 
shellversion+=" ${BASH_VERSION/-*}" 
versibash=$shellversion
# Getting OS Information
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
domain=$(cat /etc/v2ray/domain)
Sver=$(cat /home/version)
tele=$(cat /home/contact)
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	uram=$( free -m | awk 'NR==2 {print $3}' )
	fram=$( free -m | awk 'NR==2 {print $4}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
name=$(curl -sS https://raw.githubusercontent.com/Diyserver/new/main/authipvps | grep $IPVPS | awk '{print $2}')
exp=$(curl -sS https://raw.githubusercontent.com/Diyserver/new/main/authipvps | grep $IPVPS | awk '{print $3}')
clear
echo -e ""
figlet Squidvpn | lolcat
echo -e "$green Premium Script"$NC
echo -e "${green}════════════════════════════════════════════════════════════${NC}"
echo -e "${BGBLUE}                      SERVER INFORMATION                    ${NC}"
echo -e "${green}════════════════════════════════════════════════════════════${NC}"
echo -e "$green CPU Model            :$CYAN $cname"$NC
echo -e "$green CPU Frequency        :$CYAN $freq MHz"$NC
echo -e "$green Number Of Cores      :$CYAN $cores"$NC
echo -e "$green CPU Usage            :$CYAN $cpu_usage"$NC
echo -e "$green Operating System     :$CYAN "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`$NC
echo -e "$green Kernel               :$CYAN `uname -r`"$NC
echo -e "$green Bash Ver             :$CYAN $versibash"$NC
echo -e "$green Total Amount Of RAM  :$CYAN $tram MB"$NC
echo -e "$green Used RAM             :$CYAN $uram MB"$NC
echo -e "$green Free RAM             :$CYAN $fram MB"$NC
echo -e "$green System Uptime        :$CYAN $uptime $DF( From VPS Booting )"$NC
echo -e "$green Download             :$CYAN $downloadsize GB ( From Startup / VPS Booting )"$NC
echo -e "$green Upload               :$CYAN $uploadsize GB ( From Startup / VPS Booting )"$NC
echo -e "$green ISP NAME             :$CYAN $ISP"$NC
echo -e "$green IP VPS               :$CYAN $IPVPS"$NC
echo -e "$green DOMAIN               :$CYAN $domain"$NC
echo -e "$green City                 :$CYAN $CITY"$NC
echo -e "$green SERVER               :$CYAN $ISP"$NC
echo -e "$green Client Name          :$CYAN $name${NC}"
echo -e "$green Expired Date         :$CYAN $exp${NC}"
echo -e "$green Provided By          :$CYAN @anakjati567"$NC
echo -e "$green Script Version       :$CYAN $Sver"
echo -e "${green}════════════════════════════════════════════════════════════${NC}"
echo -e "${BGBLUE}                     [ MAIN MENU ]                          ${NC}"
echo -e "${green}════════════════════════════════════════════════════════════${NC}"
echo -e "$green (•1) $NC PANEL SSH & OPENVPN         $green (•7) $NC SYSTEM MENU "
echo -e "$green (•2) $NC PANEL WIREGUARDS            $green (•8) $NC CHANGE PORT VPN "
echo -e "$green (•3) $NC PANEL VMESS & VLESS         $green (•9) $NC Info Script Auto "
echo -e "$green (•4) $NC PANEL TROJAN                $green (10) $NC Check Usage "
echo -e "$green (•5) $NC PANEL SS & SSR              $green (11) $NC REBOOT VPS "
echo -e "$green (•6) $NC PANEL GRPC                  $green (12) $NC CHECK RUNNING SC "
echo -e "${green}════════════════════════════════════════════════════════════${NC}"
echo -e " Premium VPS by @Norulezzx"
echo -e " Thank you for using script by Diyvpn"
echo -e "${green}════════════════════════════════════════════════════════════${NC}"
echo -e   ""
echo -e "[Ctrl + C] For exit from main menu"
echo -e   ""
read -p "Select From Options [1-12 or x] :  " menu
echo -e ""
case $menu in
1)
menu-ssh
;;
2)
menu-wg
;;
3)
menu-v2ray
;;
4)
menu-trojan
;;
5)
menu-ssr
;;
6)
menu-grpc
;;
7)
system-menu
;;
8)
change-port
;;
9)
about
;;
10)
ram
;;
11)
reboot
;;
12)
running
;;
x)
clear
exit
;;
*)
echo " Tolong masukkan nombor yang betul!!"
sleep 2 
menu
;;
esac