#!/bin/bash

#Colores
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
morado="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
gris="\e[0;37m\033[1m"
fin="\033[0m\e[0m"

usuario=${SUDO_USER:-$USER}

sudo ifconfig $1 down
sudo airmon-ng check kill
sudo ifconfig $1 up
sudo airmon-ng start $1
interface=$(ifconfig | grep "wlan.mon" | cut -d ":" -f 1)
sudo ifconfig $interface down
sudo macchanger -r $interface
sudo ifconfig $interface up
permanent=$(sudo macchanger -s $interface | tail -n 1  | cut -b 16-32)
current=$(sudo macchanger -s $interface | head -n 1 | cut -b 16-32)
clear
echo -e "${amarillo}Combat-mode:${fin} ${verde}ENABLE${fin} ${azul}$interface${fin} "
echo -e "${amarillo}Tu MAC permanente es >${fin} ${azul}$permanent${fin}"
echo -e "${amarillo}Tu MAC actual es     >${fin} ${azul}$current${fin}"
exit
