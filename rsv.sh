#!/bin/bash
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

#DATA VALIDATION
rm -rf /etc/.vvt
mkdir /etc/.vvt
touch /etc/.vvt/ip
touch /etc/.vvt/ip1
touch /etc/.vvt/exp
touch /etc/.vvt/chatidbw
touch /etc/.vvt/name
touch /etc/.vvt/chatidbak
touch /root/limitxray.log
apt install jq curl -y
apt install curl sudo -y
clear
link="https://raw.githubusercontent.com/rsvofc/tool/rsv/"
MYIP=$(curl -sS ipv4.icanhazip.com)
echo $MYIP > /etc/.vvt/ipv4
echo $ipv4 > /etc/.vvt/ip

read -p "Your Name : " name1
    if [ -z $name1 ]; then
    echo -e "${RED}Empty name, then use a random Name${NC}"
    rname=$(</dev/urandom tr -dc 0-9 | head -c5)
    name="RSV${rname}"
    echo $name > /etc/.vvt/name
    else
    echo $name1 > /etc/.vvt/name
    fi
    
IP1=$(curl -sS ipv4.icanhazip.com)
echo "$IP1" > /etc/.vvt/ip1
echo "5908612911" > /etc/.vvt/chatidbw
echo "5908612911" > /etc/.vvt/chatidbak
clear
RGN=$(curl -s ipinfo.io/city)
PROVIDER=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
today=$(date -d +0day +%Y-%m-%d)
version=$(curl -sS ${link}/version)
myuser=$(cat /etc/.vvt/name)
cat > /etc/.vvt/version << END
$version
END
echo "$version" > /etc/.vvt/version
touch /etc/version
cat > /etc/version << END
$version
END
clear
red "YOUR DATA INFORMATION"
echo ""
echo -e "Your Name     : ${CYAN}$myuser${NC}"
echo -e "Your IP VPS   : ${ORANGE}$IP1${NC}"
echo -e "Region        : ${GREEN}$RGN${NC}"
echo -e "ISP           : ${GREEN}$PROVIDER${NC}"
echo ""
purple "Installation will be started in 5 Seconds"
sleep 5
TIMES="10"
CHATID="5908612911"
KEY="6980250010:AAFSowqhte0qjDHFuEmeDj7EQt6vFBiaqjY"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="
<u>INSTALLATION SCRIPT</u>

<code>Name          : </code><code>${myuser}</code>
<code>IP            : </code><code>${IP1}</code>
<code>Region        : </code><code>${RGN}</code>
<code>ISP           : </code><code>${PROVIDER}</code>
"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
green "INSTALATION STARTED"

cd /root
apt install jq curl -y
apt install curl sudo -y
sudo apt install megatools
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir /etc/xraylog >> /dev/null 2>&1
touch /etc/xray/domain
rm -rf /etc/usg
rm -rf /etc/lmt
rm -rf /etc/client
mkdir /etc/usg
mkdir /etc/lmt
mkdir /etc/client
touch /etc/client/vms.txt
touch /etc/client/vls.txt
touch /etc/client/trj.txt
echo "# Vmess User #" > /etc/client/vms.txt
echo "# Vless User #" > /etc/client/vls.txt
echo "# Trojan User #" > /etc/client/trj.txt
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
sleep 0.5
mkdir /user >> /dev/null 2>&1
apt install resolvconf network-manager dnsutils bind9 -y
cat > /etc/systemd/resolved.conf << END
[Resolve]
DNS=1.1.1.1 1.0.0.1
Domains=~.
ReadEtcHosts=yes
END
systemctl enable resolvconf
systemctl enable systemd-resolved
systemctl enable NetworkManager
rm -rf /etc/resolv.conf
rm -rf /etc/resolvconf/resolv.conf.d/head
echo "
nameserver 1.1.1.1
" >> /etc/resolv.conf
echo "
" >> /etc/resolvconf/resolv.conf.d/head
systemctl restart resolvconf
systemctl restart systemd-resolved
systemctl restart NetworkManager
echo "Cloudflare DNS" > /user/current

mkdir -p /var/lib/zenhost >/dev/null 2>&1
echo "IP=" >> /var/lib/zenhost/ipvps.conf

mkdir -p /usr/local/etc/xray
rm /usr/local/etc/xray/city >> /dev/null 2>&1
rm /usr/local/etc/xray/org >> /dev/null 2>&1
rm /usr/local/etc/xray/timezone >> /dev/null 2>&1

curl -s ipinfo.io/city >> /usr/local/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /usr/local/etc/xray/org
curl -s ipinfo.io/timezone >> /usr/local/etc/xray/timezone
echo ""
clear
yellow "Creating Auto Domain"
# // String / Request Data
sub=$(</dev/urandom tr -dc a-z0-9 | head -c5)
DOMAIN=vpnme.biz.id
SUB_DOMAIN=${sub}.vpnme.biz.id
CF_ID=cloudflaredomainpanel@gmail.com
CF_KEY=91b7451cf8fed9cbc1c4ca31931ffce8741f6
set -euo pipefail
IP=$(curl -sS ifconfig.me);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
     
echo "Host : $SUB_DOMAIN"
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "IP=$SUB_DOMAIN" > /var/lib/zenhost/ipvps.conf
sleep 1
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
sleep 2
clear
green "Creating Wilcard NonTLS Domain"
DOMAIN=vpnme.biz.id
WC_DOMAIN=*.${sub}.vpnme.biz.id
CF_ID=cloudflaredomainpanel@gmail.com
CF_KEY=91b7451cf8fed9cbc1c4ca31931ffce8741f6
set -euo pipefail
IP=$(curl -sS ifconfig.me);
echo "Updating DNS for ${WC_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${WC_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${WC_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${WC_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
     
green "Done"
sleep 3
sts=jancok
echo $sts > /home/email
clear   
#install ssh ovpn
wget -q ${link}/1.sh && chmod +x 1.sh && ./1.sh
#install backup
wget -q ${link}/2.sh && chmod +x 2.sh && ./2.sh
#Instal Xray
wget -q ${link}/3.sh && chmod +x 3.sh && ./3.sh
wget -q ${link}/4.sh && chmod +x 4.sh && ./4.sh
wget -q ${link}/5.sh && chmod +x 5.sh && ./5.sh
wget -q ${link}/6.sh && chmod +x 6.sh && ./6.sh

#Setting CronJob
#cat <(crontab -l) <(echo "*/40 * * * * /usr/bin/booster") | crontab -
cat <(crontab -l) <(echo "*/30 * * * * /usr/bin/sshxp") | crontab -
cat <(crontab -l) <(echo "@hourly /usr/bin/xrayxp") | crontab -
cat <(crontab -l) <(echo "@hourly /usr/bin/bwusage") | crontab -
cat <(crontab -l) <(echo "@hourly systemctl restart net0") | crontab -
cat <(crontab -l) <(echo "@hourly systemctl restart udpgw") | crontab -
cat <(crontab -l) <(echo "@reboot systemctl restart stunnel4") | crontab -
cat <(crontab -l) <(echo "0 4 * * * /usr/sbin/reboot") | crontab -

service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1
clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
datavpn
END
chmod 644 /root/.profile

history -c
clear
echo ""
green " INSTALLATION SUCCESS"
echo ""
echo -e " ${BLUE}Services${NC}             ${ORANGE}Feature${NC}"
echo ""
echo -e " SSH WEBSOCKET        Fully Automatic Script"
echo -e " XRAY VMESS           Backup & Restore"
echo -e " XRAY VLESS           Check Create Account"
echo -e " XRAY TROJAN          AutoDelete Expired User"
echo -e " UDP CUSTOM           Limit Quota Xray User"
echo -e "                      Lock SSH Multilogin User"
echo -e "                      Backup notif to Bot"
#echo -e "                      AutoReboot on 04.00 GMT+7"
echo ""
red " © Zenvio 2021-2024"
rm /root/install >/dev/null 2>&1
rm /root/1.sh >/dev/null 2>&10
rm /root/2.sh >/dev/null 2>&10
rm /root/3.sh >/dev/null 2>&10
rm /root/4.sh >/dev/null 2>&10
rm /root/5.sh >/dev/null 2>&10
rm /root/6.sh >/dev/null 2>&10
echo -e ""
red "Warning !!"
echo "Reboot in 10 Seconds"
sleep 10
red "Rebooting..."
sleep 1
reboot
