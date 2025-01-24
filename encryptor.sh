#!/bin/bash

# Warna
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Direktori
INPUT_DIR="/root/rsv/originfile"
OUTPUT_DIR="/root/rsv/encryptfile"
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

# Fungsi untuk menampilkan header
display_header() {
    clear
    echo -e "${PURPLE}===============================";
    echo -e "    Shell Encryptor by RSV    ";
    echo -e "===============================${NC}";
}

# Fungsi enkripsi file
encrypt_files() {
    display_header
    echo "Memulai proses enkripsi..."
    
    # Pastikan direktori ada
    mkdir -p "$INPUT_DIR"
    mkdir -p "$OUTPUT_DIR"

    # Loop melalui semua file di direktori input
    for file in "$INPUT_DIR"/*; do
        if [[ -f "$file" ]]; then
            if bash -n "$file" 2>/dev/null; then
                filename=$(basename -- "$file")
                encrypted_file="$OUTPUT_DIR/$filename"

                echo "Encrypting $file -> $encrypted_file"
                obash -r -o "$encrypted_file" "$file" >/dev/null 2>&1
                rm -rf /$INPUT_DIR/*.c
                rm -rf /$OUTPUT_DIR/*.c

                if [[ $? -eq 0 ]]; then
                    echo "Successfully encrypted: $encrypted_file"
                    echo "Sebaiknya segera hapus original file setelah di encrypt"
                else
                    echo "Failed to encrypt: $file"
                fi
            else
                echo "Skipping $file: Not a valid Bash script"
            fi
        fi
    done

    echo "Proses enkripsi selesai."
    read -p "Tekan Enter untuk kembali ke menu..."
}

# Fungsi cek file belum dienkripsi
check_unencrypted_files() {
    display_header
    echo "Masukan file ke /root/rsv/originfile"
    echo -e "${PURPLE}Daftar File Belum Dienkripsi:${NC}"
    echo " ----------------------------------------"
    
    if [ -z "$(ls -A "$INPUT_DIR")" ]; then
        echo "Tidak ada file di direktori"
        echo "Letak folder /root/rsv/originfile"
    else
        # Tampilkan dalam format tabel
        printf "| %-5s | %-30s |\n" "No." "Nama File"
        printf "|-------|--------------------------------|\n"
        
        
        count=1
        for file in "$INPUT_DIR"/*; do
            if [[ -f "$file" ]]; then
                filename=$(basename -- "$file")
                printf "| %-5s | %-30s |\n" "$count" "$filename"
                ((count++))
            fi
        done
    fi

    read -p "Tekan Enter untuk kembali ke menu..."
}

# Fungsi cek file sudah dienkripsi
check_encrypted_files() {
    display_header
    echo "Letak file di /root/rsv/encryptfile"
    echo "Rekomendasi unduh file menggunakan SFTP"
    echo -e "${PURPLE}Daftar File Sudah Dienkripsi:${NC}"
    echo " ----------------------------------------"
    
    if [ -z "$(ls -A "$OUTPUT_DIR")" ]; then
        echo "Tidak ada file yang dienkripsi"
        echo "Letak folder /etc/rsv/originfile"
    else
        # Tampilkan dalam format tabel
        printf "| %-5s | %-30s |\n" "No." "Nama File"
        printf "|-------|--------------------------------|\n"
        
        count=1
        for file in "$OUTPUT_DIR"/*; do
            if [[ -f "$file" ]]; then
                filename=$(basename -- "$file")
                printf "| %-5s | %-30s |\n" "$count" "$filename"
                ((count++))
            fi
        done
    fi

    read -p "Tekan Enter untuk kembali ke menu..."
}

delete_unencrypted_files() {
   display_header
   echo "Proses menghapus file original"
   sleep 2
   rm -rf /root/rsv/originfile/*
   echo "Berhasil"
   
   read -p "Tekan Enter untuk kembali ke menu..."
}

# Menu utama
main_menu() {
    while true; do
        display_header
        echo "Pilih Opsi:"
        echo "1. Enkripsi File"
        echo "2. Cek File Belum Dienkripsi"
        echo "3. Cek File Sudah Dienkripsi"
        echo "4. Hapus file original (Jika sudah di encrypt)"
        echo "5. Keluar"
        read -p "Masukkan pilihan (1-4): " choice

        case $choice in
            1) encrypt_files ;;
            2) check_unencrypted_files ;;
            3) check_encrypted_files ;;
            4) delete_unencrypted_files ;;
            5) exit 0 ;;
            *) 
                echo "Pilihan tidak valid!"
                read -p "Tekan Enter untuk melanjutkan..." 
                ;;
        esac
    done
}

# Jalankan menu utama
check_access
clear
main_menu