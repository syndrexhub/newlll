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
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}         ┃ PANEL VMESS WEBSOCKET ┃        ${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e "$green (•1) $NC Create Vmess Websocket Account"
echo -e "$green (•2) $NC Delete Vmess Websocket Account"
echo -e "$green (•3) $NC Renew Vmess Account"
echo -e "$green (•4) $NC Check User Login Vmess"
echo -e ""
echo -e "$CYAN       >> Total   : $(grep -c -E "^###" "/etc/v2ray/config.json")${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}        ┃ PANEL VLESS WEBSOCKET ┃         ${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e "$green (•5) $NC Create Vless Websocket Account"
echo -e "$green (•6) $NC Deleting Vless Websocket Account"
echo -e "$green (•7) $NC Renew Vless Account"
echo -e "$green (•8) $NC Check User Login Vless"
echo -e ""
echo -e "$CYAN        >> Total   : $(grep -c -E "^###" "/etc/v2ray/vless.json")${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}          ┃ PANEL XRAY  ┃                 ${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e "$green (•9) $NC Create Xray VLess XTLS Account"
echo -e "$green (10) $NC Deleting Xray Vless XTLS Account"
echo -e "$green (11) $NC Renew Xray Vless XTLS Account"
echo -e ""
echo -e "$CYAN       >> Total   : $(grep -c -E "^###" "/etc/xray-mini/vless-direct.json")${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e " ${BGBLUE}         x)   MENU                        ${NC}"
echo -e "${green} ══════════════════════════════════════════${NC}"
echo -e ""
read -p "   Select From Options [1-11 or x]: " menuvmess
echo -e ""
case $menuvmess in
1)
add-ws
;;
2)
del-ws
;;
3)
renew-ws
;;
4)
cek-ws
;;
5)
add-vless
;;
6)
del-vless
;;
7)
renew-vless
;;
8)
cek-vless
;;
9)
add-xray
;;
10)
del-xray
;;
11)
renew-xray
;;
x)
menu
;;
*)
echo " Please enter an correct number!!"
;;
esac