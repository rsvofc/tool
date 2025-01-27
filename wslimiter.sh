#!/bin/bash
# Traffic Control Manager by RSV (TC Version)
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

# Function to list active interfaces
list_interfaces() {
    echo -e "${CYAN}Available network interfaces:${NC}"
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

# Function to validate speed (minimum 1 Mbps)
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

# Function to check current tc status
check_status() {
    local interface=$1
    echo -e "${CYAN}Checking traffic control rules for $interface...${NC}"
    
    echo -e "\n${BLUE}Download (ingress) limits:${NC}"
    tc qdisc show dev "$interface" ingress 2>/dev/null
    tc filter show dev "$interface" parent ffff: 2>/dev/null
    
    echo -e "\n${BLUE}Upload (egress) limits:${NC}"
    tc qdisc show dev "$interface" root 2>/dev/null
    
    if ! tc qdisc show dev "$interface" | grep -q "tbf\|ingress"; then
        echo -e "\n${ORANGE}No active traffic shaping rules found for $interface${NC}"
    fi
}

# Function to set upload limit
set_upload_limit() {
    local interface=$1
    local speed=$2
    
    # Remove existing upload limit if any
    tc qdisc del dev "$interface" root 2>/dev/null
    
    # Apply new upload limit
    if tc qdisc add dev "$interface" root tbf rate "${speed}mbit" burst 32kbit latency 400ms; then
        echo -e "${GREEN}Upload limit of ${speed}Mbps has been set on $interface${NC}"
    else
        echo -e "${RED}Failed to set upload limit${NC}"
        return 1
    fi
}

# Function to set download limit
set_download_limit() {
    local interface=$1
    local speed=$2
    
    # Remove existing download limit if any
    tc qdisc del dev "$interface" ingress 2>/dev/null
    
    # Add ingress qdisc
    tc qdisc add dev "$interface" handle ffff: ingress
    
    # Apply new download limit
    if tc filter add dev "$interface" parent ffff: protocol ip u32 match u32 0 0 police rate "${speed}mbit" burst 32k drop; then
        echo -e "${GREEN}Download limit of ${speed}Mbps has been set on $interface${NC}"
    else
        echo -e "${RED}Failed to set download limit${NC}"
        return 1
    fi
}

# Function to clear all limits
clear_limits() {
    local interface=$1
    
    # Clear upload limit
    tc qdisc del dev "$interface" root 2>/dev/null
    
    # Clear download limit
    tc qdisc del dev "$interface" ingress 2>/dev/null
    
    echo -e "${GREEN}All traffic limits have been cleared from $interface${NC}"
}

# Function to perform speed test
perform_speedtest() {
    echo -e "${CYAN}Running speed test...${NC}"
    speedtest
}

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root${NC}"
    exit 1
fi

# Main menu
while true; do
    clear
    echo -e "============================================"
    echo -e "${PURPLE}     Traffic Control Management Script${NC}"
    echo -e "============================================"
    echo -e "1. Check/Change Active Interface"
    echo -e "2. Set Speed Limits"
    echo -e "3. Clear All Settings"
    echo -e "4. Check Current Status"
    echo -e "5. Run Speed Test"
    echo -e "6. Exit"
    echo -e "============================================"
    read -p "Choose an option (1-6): " choice

    case $choice in
        1)
            list_interfaces
            read -p "Enter interface name to use: " interface
            if validate_interface "$interface"; then
                echo -e "${GREEN}Selected interface: $interface${NC}"
                sleep 2
            fi
            ;;
        2)
            if [ -z "$interface" ]; then
                echo -e "${RED}Please select an interface first (Option 1)${NC}"
                sleep 2
                continue
            fi
            
            echo -e "${CYAN}Setting speed limits for $interface${NC}"
            echo "1. Set Download Limit"
            echo "2. Set Upload Limit"
            echo "3. Set Both"
            read -p "Choose option (1-3): " limit_choice
            
            case $limit_choice in
                1)
                    read -p "Enter download speed limit (Mbps): " download_speed
                    if validate_speed "$download_speed"; then
                        set_download_limit "$interface" "$download_speed"
                    fi
                    ;;
                2)
                    read -p "Enter upload speed limit (Mbps): " upload_speed
                    if validate_speed "$upload_speed"; then
                        set_upload_limit "$interface" "$upload_speed"
                    fi
                    ;;
                3)
                    read -p "Enter download speed limit (Mbps): " download_speed
                    read -p "Enter upload speed limit (Mbps): " upload_speed
                    if validate_speed "$download_speed" && validate_speed "$upload_speed"; then
                        set_download_limit "$interface" "$download_speed"
                        set_upload_limit "$interface" "$upload_speed"
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
                echo -e "${RED}Please select an interface first (Option 1)${NC}"
            else
                clear_limits "$interface"
            fi
            sleep 2
            ;;
        4)
            if [ -z "$interface" ]; then
                echo -e "${RED}Please select an interface first (Option 1)${NC}"
            else
                check_status "$interface"
                read -p "Press Enter to continue..."
            fi
            ;;
        5)
            perform_speedtest
            read -p "Press Enter to continue..."
            ;;
        6)
            echo -e "${GREEN}Exiting...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            sleep 2
            ;;
    esac
done