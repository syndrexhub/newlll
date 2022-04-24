#!/bin/bash
green='\e[32m'
RED='\033[0;31m'
NC='\033[0m'
BGBLUE='\e[1;44m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear
echo -e "${ORANGE}=============================================${NC}"
echo -e "${BGBLUE} RECERT V2RAY                            ${NC}"
echo -e "${ORANGE}=============================================${NC}"
sleep 1
echo start
sleep 0.5
domain=$(cat /etc/v2ray/domain)
systemctl stop v2ray
systemctl stop v2ray@none
systemctl stop v2ray@vless.service
systemctl stop v2ray@vnone.service
systemctl stop trojan
systemctl stop xray-mini@vless-direct
systemctl stop xray-mini@vless-splice
~/.acme.sh/acme.sh --renew -d $domain --standalone -k ec-256 --force --ecc
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
systemctl start v2ray
systemctl start v2ray@none
systemctl start v2ray@vless.service
systemctl start v2ray@vnone.service
systemctl start trojan
systemctl start xray-mini@vless-splice
systemctl start xray-mini@vless-splice
echo Done
sleep 0.5
clear
echo -e "${ORANGE}=============================================${NC}"
echo -e "${BGBLUE} RECERT DOMAIN SELESAI                      ${NC}"
echo -e "${ORANGE}=============================================${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu