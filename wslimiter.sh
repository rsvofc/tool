#!/bin/bash
# Wondershapper manager by RSV
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# Function to check if wondershaper is installed
check_wondershaper() {
    if ! command -v wondershaper &> /dev/null; then
        echo -e "${RED}Wondershaper is not installed. Please install it first${NC}"
        exit 1
    fi
}

# Function to list active interfaces
list_interfaces() {
    echo "Available network interfaces:"
    ip -br link show | grep -v "lo" | awk '{print $1}'
}

# Function to validate interface
validate_interface() {
    local interface=$1
    if ! ip link show "$interface" &> /dev/null; then
        echo -e "${RED}Interface $interface does not exist${NC}"
        return 1
    fi
    return 0
}

# Function to validate speed (minimum 5 Mbps)
validate_speed() {
    local speed=$1
    if ! [[ "$speed" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Please enter a valid number${NC}"
        return 1
    fi
    if [ "$speed" -lt 5 ]; then
        echo -e "${RED}Speed must be at least 5 Mbps${NC}"
        return 1
    fi
    return 0
}

# Function to perform speed test
perform_speedtest() {
    if ! command -v speedtest &> /dev/null; then
        echo "Installing speedtest-cli..."
        if [ -f /etc/debian_version ]; then
            apt-get update
            apt-get install -y speedtest-cli
        elif [ -f /etc/redhat-release ]; then
            yum install -y speedtest-cli
        fi
    fi
    echo "Running speed test..."
    speedtest
}

# Main menu
while true; do
    clear
    echo -e "============================================"
    echo -e "${PURPLE}     Wondershaper Management Script${NC}"
    echo -e "============================================"
    echo "1. Check/Change Active Interface"
    echo "2. Set Speed Limits"
    echo "3. Clear All Settings"
    echo "4. Run Speed Test"
    echo "5. Exit"
    echo "============================================"
    read -p "Choose an option (1-5): " choice

    case $choice in
        1)
            list_interfaces
            read -p "Enter interface name to use: " interface
            if validate_interface "$interface"; then
                echo "Selected interface: $interface"
                echo -e "${GREEN}Interface saved!${NC}"
                sleep 2
            fi
            ;;
        2)
            if [ -z "$interface" ]; then
                echo -e "${RED}Please select an interface first (Di menu No.1)${NC}"
                sleep 2
                continue
            fi
            
            echo "Setting speed limits for $interface"
            echo "1. Set Download Limit"
            echo "2. Set Upload Limit"
            echo "3. Set Both(Keduanya)"
            read -p "Choose option (1-3): " limit_choice
            
            case $limit_choice in
                1)
                    read -p "Enter download speed limit (Mbps): " download_speed
                    if validate_speed "$download_speed"; then
                        wondershaper -a "$interface" -d "$((download_speed * 1024))"
                        echo "Download limit set to $download_speed Mbps"
                    fi
                    ;;
                2)
                    read -p "Enter upload speed limit (Mbps): " upload_speed
                    if validate_speed "$upload_speed"; then
                        wondershaper -a "$interface" -u "$((upload_speed * 1024))"
                        echo "Upload limit set to $upload_speed Mbps"
                    fi
                    ;;
                3)
                    read -p "Enter download speed limit (Mbps): " download_speed
                    read -p "Enter upload speed limit (Mbps): " upload_speed
                    if validate_speed "$download_speed" && validate_speed "$upload_speed"; then
                        wondershaper -a "$interface" -d "$((download_speed * 1024))" -u "$((upload_speed * 1024))"
                        echo "Limits set: Download=$download_speed Mbps, Upload=$upload_speed Mbps"
                    fi
                    ;;
                *)
                    echo -e "${RED}Invalid option${NC}"
                    ;;
            esac
            sleep 2
            ;;
        3)
            if [ -z "$interface" ]; then
                echo -e "${RED}Please select an interface first (Di menu No.1)${NC}"
            else
                wondershaper -c -a "$interface"
                echo -e "${GREEN}All limits cleared for $interface${NC}"
            fi
            sleep 2
            ;;
        4)
            perform_speedtest
            read -p "Press Enter to continue..."
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            sleep 2
            ;;
    esac
done