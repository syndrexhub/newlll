#!/bin/bash
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
    curl -sS https://raw.githubusercontent.com/izhanworks/izvpnauthip/main/authipvps > /root/tmp
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
Name=$(curl -sS https://raw.githubusercontent.com/izhanworks/izvpnauthip/main/authipvps | grep $MYIP | awk '{print $2}')
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
    IZIN=$(curl -sS https://raw.githubusercontent.com/izhanworks/izvpnauthip/main/authipvps | awk '{print $4}' | grep $MYIP)
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
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}          ┃ PANEL PPTP  ┃                 ${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e "$green (•1) $NC Create Account PPTP\e[0m"
echo -e "$green (•2) $NC Delete PPTP Account\e[0m"
echo -e "$green (•3) $NC Extending PPTP Account Active Life\e[0m"
echo -e "$green (•4) $NC Check User Login PPTP\e[0m"
echo -e ""
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}          ┃ PANEL L2TP  ┃                 ${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e "$green (•5) $NC Creating L2TP Account\e[0m"
echo -e "$green (•6) $NC Deleting L2TP Account\e[0m"
echo -e "$green (•7) $NC Extending L2TP Account Active Life\e[0m"
echo -e ""
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}          ┃ PANEL SSTP  ┃                 ${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e "$green (•8) $NC Create Account SSTP\e[0m\e[0m"
echo -e "$green (•9) $NC Delete SSTP Account\e[0m\e[0m"
echo -e "$green (10) $NC Extending SSTP Account Active Life\e[0m"
echo -e "$green (11) $NC Check User Login SSTP\e[0m"
echo -e ""
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}         x)   MENU                        ${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e ""
read -p "    Select From Options [1-11 or x]: " menupptp
echo -e ""
case $menupptp in
1)
add-pptp
;;
2)
del-pptp
;;
3)
renew-pptp
;;
4)
cek-pptp
;;
5)
add-l2tp
;;
6)
del-l2tp
;;
7)
renew-l2tp
;;
8)
add-sstp
;;
9)
del-sstp
;;
10)
renew-sstp
;;
11)
cek-sstp
;;
x)
menu
;;
*)
echo " Please enter an correct number!!"
;;
esac