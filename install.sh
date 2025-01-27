#!/bin/bash
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear
echo -e "${GREEN}Bandwidth Limit Installer by RSV${NC}"
sleep 5
wget -q -O /usr/sbin/vpslimiter "https://raw.githubusercontent.com/rsvofc/tool/savina/wslimiter.sh"
echo -e "${GREEN}Installed successfully!${NC}"
echo -e "Ketik ${BLUE}[vpslimiter]${NC} untuk menjalankan"
chmod +x /usr/sbin/vpslimiter
exit 0
