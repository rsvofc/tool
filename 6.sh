#!/bin/bash
# Provide by Zenvio
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
link="https://raw.githubusercontent.com/rsvofc/tool/rsv/"
red " UDP CUSTOM INSTALL"
cd 
rm -rf /root/udp
mkdir -p /root/udp
rm -rf /etc/UDPCustom
mkdir -p /etc/UDPCustom
sudo touch /etc/UDPCustom/udp-custom
udp_dir='/etc/UDPCustom'
udp_file='/etc/UDPCustom/udp-custom'

source <(curl -sSL 'https://raw.githubusercontent.com/sreyaeve/rsvzen/main/udp-custom/system/module')
  #
  rm -rf $udp_file &>/dev/null
  rm -rf /etc/UDPCustom/udp-custom &>/dev/null
  rm -rf /etc/limiter.sh &>/dev/null
  rm -rf /etc/UDPCustom/limiter.sh &>/dev/null
  rm -rf /etc/UDPCustom/module &>/dev/null
  rm -rf /usr/bin/udp &>/dev/null
  rm -rf /etc/UDPCustom/udpgw.service &>/dev/null
  rm -rf /etc/udpgw.service &>/dev/null
  systemctl stop udpgw &>/dev/null
  systemctl stop udp-custom &>/dev/null
 #GET File
  source <(curl -sSL 'https://raw.githubusercontent.com/sreyaeve/rsvzen/main/udp-custom/system/module') &>/dev/null
  wget -q -O /etc/UDPCustom/module 'https://raw.githubusercontent.com/sreyaeve/rsvzen/main/udp-custom/system/module' &>/dev/null
  chmod +x /etc/UDPCustom/module
  wget -q "https://raw.githubusercontent.com/sreyaeve/rsvzen/main/udp-custom/system/udp-custom-linux-amd64" -O /root/udp/udp-custom &>/dev/null
  chmod +x /root/udp/udp-custom
  wget -q -O /etc/udpgw 'https://raw.githubusercontent.com/sreyaeve/rsvzen/main/udp-custom/system/udpgw'
  mv /etc/udpgw /bin
  chmod +x /bin/udpgw
  #Service
  wget -q -O /etc/udpgw.service 'https://raw.githubusercontent.com/sreyaeve/rsvzen/main/udp-custom/system/udpgw.service'
  wget -q -O /etc/udp-custom.service 'https://raw.githubusercontent.com/sreyaeve/rsvzen/main/udp-custom/system/udp-custom.service'
  
  mv /etc/udpgw.service /etc/systemd/system
  mv /etc/udp-custom.service /etc/systemd/system

  chmod 640 /etc/systemd/system/udpgw.service
  chmod 640 /etc/systemd/system/udp-custom.service
  
  systemctl daemon-reload &>/dev/null
  systemctl enable udpgw &>/dev/null
  systemctl start udpgw &>/dev/null
  systemctl enable udp-custom &>/dev/null
  systemctl start udp-custom &>/dev/null

  #Config
  wget -q "https://raw.githubusercontent.com/sreyaeve/rsvzen/main/udp-custom/system/config.json" -O /root/udp/config.json &>/dev/null
  chmod +x /root/udp/config.json
  
  ufw disable &>/dev/null
  sudo apt-get remove --purge ufw firewalld -y
  apt remove netfilter-persistent -y
red " DONE "
clear