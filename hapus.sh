#!/bin/bash
RED='\e[1;31m'
GREEN='\e[0;32m'
BLUE='\e[0;34m'
BGRED='\e[1;41m'
BGGREEN='\e[1;42m'
BGYELLOW='\e[1;43m'
BGBLUE='\e[1;44m'
NC='\e[0m'

NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/pakya/ssh_account")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "Tidak Ada Akaun SSH Terdaftar Di VPS"
		exit 1
	fi

	clear
	echo ""
echo -e "${GREEN}══════════════════════════════════${NC}"
echo -e "${BGBLUE}          HAPUS AKUN SSH          "
echo -e "${GREEN}══════════════════════════════════${NC}"
	echo "     No User      Expired"
	grep -E "^### "     "/etc/pakya/ssh_account" | cut -d ' ' -f 2-3 | nl -s ') '
	echo ""
	echo -e "${GREEN}══════════════════════════════════${NC}"
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo ""
			read -rp "Choose Number [1]: " CLIENT_NUMBER
		else
			echo ""
			read -rp "Choose Number [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^### " "/etc/pakya/ssh_account" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/pakya/ssh_account" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/d" /etc/pakya/ssh_account
if getent passwd $user > /dev/null 2>&1; then
        userdel $user
clear
echo -e "${BGRED}        SUCCESS        ${NC}"
else
        echo -e "ERROR : User $user Not Found"
fi