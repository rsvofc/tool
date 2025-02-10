#!/bin/bash
# Script untuk instalasi otomatis berdasarkan OS
# Build by RSV
# Celana Color
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
# Fungsi untuk mendapatkan versi OS
get_os_info() {
  echo -e "${LIGHT}Checking OS systemnya${NC}"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VERSION=$VERSION_ID
    else
        echo -e "${RED}OS tidak dikenali${NC}"
        exit 1
    fi
}

check_os_support() {
    case "$OS" in
        debian)
            case "$VERSION" in
                10|11)
                    echo -e "Terdeteksi ${GREEN}Debian $VERSION${NC}"
                    echo -e "${GREEN}OS Supported bosku"
                    sleep 5
                    LINK="wget -q https://raw.githubusercontent.com/rsvofc/tool/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh"
                    ;;
                12)
                    echo -e "Terdeteksi ${GREEN}Debian $VERSION${NC}"
                    echo -e "${GREEN}OS Supported bosku"
                    sleep 5
                    LINK="wget -q https://raw.githubusercontent.com/rsvofc/tool/refs/heads/main/deb12/install.sh && chmod +x install.sh && ./install.sh"
                    ;;
                *)
                    echo -e "${RED}Debian versi $VERSION tidak didukung${NC}"
                    exit 1
                    ;;
            esac
            ;;
        ubuntu)
            case "$VERSION" in
                18.04|20.04)
                    echo -e "Terdeteksi ${GREEN}Ubuntu $VERSION${NC}"
                    echo -e "${GREEN}OS Supported bosku"
                    sleep 5
                    LINK="wget -q https://raw.githubusercontent.com/rsvofc/tool/refs/heads/main/install.sh && chmod +x install.sh && ./install.sh"
                    ;;
                24.04)
                    echo -e "Terdeteksi ${GREEN}Ubuntu $VERSION${NC}"
                    echo -e "${GREEN}OS Supported bosku"
                    sleep 5
                    LINK="wget -q https://raw.githubusercontent.com/rsvofc/tool/refs/heads/main/deb12/install.sh && chmod +x install.sh && ./install.sh"
                    ;;
                *)
                    echo -e "${RED}Ubuntu versi $VERSION tidak didukung${NC}"
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo -e "${RED}OS $OS tidak didukung${NC}"
            exit 1
            ;;
    esac
}

run_installation() {
    echo -e "${GREEN}Installer Script by RSV${NC}"
    eval "$LINK"
    rm -rf rsvenc.sh
}

# Main script
get_os_info
clear
check_os_support
run_installation