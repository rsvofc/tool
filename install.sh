#!/bin/bash

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_access() {
    # URL daftar IP dan kode akses
    ACCESS_URL="https://raw.githubusercontent.com/rsvofc/tool/main/code"
    
    # Dapatkan IP publik VPS
    VPS_IP=$(curl -s https://icanhazip.com)
    
    # Minta input kode akses dari pengguna
    echo -e "${YELLOW}Masukkan Kode Akses:${NC}"
    read -p "Kode Akses: " ACCESS_CODE

    # Unduh daftar IP dan kode
    ACCESS_LIST=$(curl -s "$ACCESS_URL")

    # Cek apakah IP dan kode cocok
    MATCH=$(echo "$ACCESS_LIST" | grep -P "^${VPS_IP}\s+${ACCESS_CODE}$")

    if [ -z "$MATCH" ]; then
        echo -e "${RED}[DITOLAK] Akses Tidak Sah!${NC}"
        echo -e "${RED}IP Anda: ${VPS_IP}${NC}"
        echo -e "${RED}Kode Akses: ${ACCESS_CODE}${NC}"
        echo -e "${GREEN}Hubungi Admin untuk mendapatkan Kode Akses${NC}"
        rm -rf install.sh
        exit 1
    else
        echo -e "${GREEN}[DIIZINKAN] Akses Berhasil!${NC}"
    fi
}
# Fungsi untuk memeriksa apakah script dijalankan sebagai root
check_root() {
    if [[ $EUID -ne 0 ]]; then
       echo -e "${RED}[ERROR] Script ini harus dijalankan dengan sudo atau sebagai root!${NC}" 
       exit 1
    fi
}

# Fungsi deteksi distro
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    elif type lsb_release >/dev/null 2>&1; then
        DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        DISTRO=$DISTRIB_ID
    else
        echo -e "${RED}[ERROR] Distribusi Linux tidak terdeteksi!${NC}"
        exit 1
    fi
    echo -e "${GREEN}[INFO] Terdeteksi Distro: ${DISTRO}${NC}"
}

# Fungsi instalasi dependensi
install_dependencies() {
    case "$DISTRO" in
        ubuntu|debian)
            export DEBIAN_FRONTEND=noninteractive
            apt update
            apt autoremove --fix-missing -y -f
            apt upgrade -y
            apt install build-essential libssl-dev curl shellcheck -y
            ;;
        rhel|fedora|centos)
            yum update -y
            yum groupinstall "Development Tools" -y
            yum install openssl-devel zip curl ShellCheck -y
            ;;
        *)
            echo -e "${RED}[ERROR] Distro tidak didukung!${NC}"
            exit 1
            ;;
    esac
}

# Fungsi download dan kompilasi obash
compile_obash() {
    # URL source obash (menggunakan versi terbaru yang tersedia)
    OBASH_VERSION="8976fd2fa256c583769b979036f59a741730eb48"
    OBASH_URL="https://github.com/louigi600/obash/archive/${OBASH_VERSION}.tar.gz"

    # Download obash
    echo -e "${YELLOW}[PROSES] Mendownload source ...${NC}"
    curl -skL "$OBASH_URL" -o obash.tgz
    
    # Ekstrak
    tar xf obash.tgz && rm -f obash.tgz

    # Kompilasi
    cd obash-8976fd2fa256c583769b979036f59a741730eb48
    make clean
    make
    mv -f obash /usr/local/sbin/obash
    cd .. && rm -rf obash-8976fd2fa256c583769b979036f59a741730eb48
    # Eksekutor
    mkdir -p /root/rsv/originfile
    mkdir -p /root/rsv/encryptlfile
    clear
    cd /usr/bin
    wget -q -O rsvenc "https://raw.githubusercontent.com/rsvofc/tool/refs/heads/main/encryptor.sh" && chmod +x rsvenc

    echo -e "${GREEN}[SUKSES] Berhasil diinstal${NC}"
    rm -rf install.sh
    rm -rf rsvenc.sh
}

# Fungsi verifikasi instalasi
verify_installation() {
    if command -v obash &> /dev/null; then
        echo -e "${GREEN}[SUKSES] Terinstal dengan benar${NC}"
        echo -e "Ketik [rsvenc] untuk masuk menu Encrypt"
        rm -rf install.sh
        rm -rf rsvenc.sh
    else
        echo -e "${RED}[GAGAL] Instalasi tidak berhasil${NC}"
        rm -rf install.sh
        rm -rf rsvenc.sh
        exit 1
    fi
}

# Fungsi utama
main() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "${GREEN}   RSV Bash Encryptor Installer       ${NC}"
    echo -e "${GREEN}====================================${NC}"

    # Jalankan fungsi-fungsi
    check_access
    check_root
    detect_distro
    install_dependencies
    compile_obash
    clear
    verify_installation
}

# Jalankan script
main
