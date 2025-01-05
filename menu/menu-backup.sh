clear
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
blue='\033[0;34m'
ungu='\033[0;35m'
Green="\033[32m"
Red="\033[31m"
WhiteB="\e[5;37m"
BlueCyan="\e[5;36m"
Green_background="\033[42;37m"
Red_background="\033[41;37m"
Suffix="\033[0m"



function Backup_Vps() {
install unzip -y
# Getting
clear
IP=$(curl -sS ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
date=$(date +"%d-%b-%Y-%T")

clear
rm -rf /root/backup
mkdir /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp -r /etc/xray backup/xray
cp -r /var/www/html/ backup/html
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1

source /media/cybervpn/var.txt && echo $BOT_TOKEN > .bot
azi=$(cat .bot)
source /media/cybervpn/var.txt && echo $ADMIN > .id
aji=$(cat .id)
curl -X POST https://api.telegram.org/bot$azi/sendDocument \
     -F "chat_id=$aji" \
     -F "document=@/root/$IP-$date.zip" \
     -F "caption=file backup mu" &> /dev/null

rm .bot
rm .id
rm -rf /root/backup
rm -r /root/$IP-$date.zip
}

function Restor_Vps() {
# Path folder root yang diinginkan
root_folder="/root/folder"

# Membuat folder jika belum ada
if [ ! -d "$root_folder" ]; then
    mkdir -p "$root_folder"
else
    echo "Folder $root_folder Already available."
fi

# Mengekstrak file ZIP di dalam root folder
if [ -n "$(ls -A "$root_folder"/*.zip 2>/dev/null)" ]; then
    for zip_file in "$root_folder"/*.zip; do
        unzip "$zip_file" -d "$root_folder"
        echo "File ZIP $zip_file berhasil diekstrak."
    done
else
    echo " There Is No Zip File In The Folder $root_folder."
fi

# Menjalankan operasi restore
cd /root/folder/backup

# Menyalin file ke lokasi tujuan mereka
cp -f passwd /etc/
cp -f group /etc/
cp -f shadow /etc/
cp -f gshadow /etc/
cp -rf xray /etc/
cp -f crontab /etc/

# Membersihkan file backup dengan path yang benar
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m         RESTORE SUCCESS           \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
sleep 3
clear
# Opsional: Menghapus backup.zip dan direktori backup
rm -rf /root/backup

# Menghapus file ZIP di dalam folder root/folder
folder="/root/folder"
if [ -d "$folder" ]; then
    if [ -n "$(ls -A "$folder"/*.zip 2>/dev/null)" ]; then
        rm "$folder"/*.zip
        echo "Semua file ZIP di dalam folder $folder telah dihapus."
    else
        echo "Tidak ada file ZIP di dalam folder $folder."
    fi
else
    echo "Folder $folder tidak ditemukan."
fi

# Menghapus folder 'backup' di dalam folder 'folder'
backup_folder="/root/folder/backup"
if [ -d "$backup_folder" ]; then
    rm -rf "$backup_folder"
    echo "Folder 'backup' di dalam 'folder' telah dihapus."
else
    echo "Folder 'backup' di dalam 'folder' tidak ditemukan."
fi
}

function Set_Br() {
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
sudo apt install ruby -y
gem install lolcat -y
apt install msmtp-mta ca-certificates bsd-mailx -y
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m        ENTER TELEGRAM ID          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "\e[96;1m MASUKAN ID TELEGRAM KAMU \e[0m"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -rp " Just Input id Telegram : " nenen
echo "$nenen" >> /root/id

cd /usr/bin
wget -O /usr/bin/m-abk "https://raw.githubusercontent.com/arjunjms/isa/momok/backup/autobackup.sh"
wget -O /usr/bin/backup "https://raw.githubusercontent.com/arjunjms/isa/momok/backup/backup.sh"
wget -O /usr/bin/restore "https://raw.githubusercontent.com/arjunjms/isa/momok/backup/restore.sh"



#wget -O mlimitspeed "https://raw.githubusercontent.com/arjunjms/isa/momok/backup/limitspeed.sh"
chmod +x /usr/bin/m-abk
chmod +x /usr/bin/mbackup
chmod +x /usr/bin/mrestore
chmod +x mlimitspeed
cd
rm -f /root/set-boba.sh
}



function Gdrive_Via() {
clear
install unzip -y
export CHATID="1846890724"
export KEY="7763089561:AAG21Zf11JelOYxhEtvNBTtc5vjYa4H6hSQ"
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
IP=$(curl -sS ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
date=$(date +"%Y-%m-%d")

clear
email=$(cat /root/email)
if [[ "$email" = "" ]]; then
clear
echo
echo -e "\e[37;1mMasukkan Email Untuk Menerima Backup"
echo -e "\e[33;1m"
read -rp "Just Input Email : " -e email
cat <<EOF>>/root/email
$email
EOF
fi
clear
echo "Mohon Menunggu , Proses Backup sedang berlangsung !!"
rm -rf /root/backup
mkdir /root/backup

cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp /etc/crontab backup/

# // db protocoll
cp /etc/vmess/.vmess.db backup/
cp /etc/ssh/.ssh.db backup/
cp /etc/vless/.vless.db backup/
cp /etc/trojan/.trojan.db backup/
cp /etc/shadowsocks/.shadowsocks.db backup/
cp /etc/bot/.bot.db /backup/
cp /etc/noobzvpns/.noobzvpns.db /backup/
cp /etc/noobs/.noobs.db /noobs/

# db lunatic
cp /etc/lunatic/vmess/.vmess.db backup/
cp /etc/lunatic/ssh/.ssh.db backup/
cp /etc/lunatic/vless/.vless.db backup/
cp /etc/lunatic/trojan/.trojan.db backup/
cp /etc/lunatic/shadowsocks/.shadowsocks.db backup/
cp /etc/lunatic/noobzvpns/.noobzvpns.db backup/
cp /etc/lunatic/sstp/.sstp.db backup/
cp /etc/lunatic/l2tp/.l2tp.db backup/
cp /etc/lunatic/bot/.bot.db backup/

# data iplimit
cp -r /etc/cybervpn/limit backup/
cp -r /etc/cybervpn/limit/vmess backup/
cp -r /etc/cybervpn/limit/trojan backup/
cp -r /etc/cybervpn/limit/vless backup/
cp -r /etc/cybervpn/limit/shadowsock backup/
cp -r /etc/cybervpn/limit/noobzvpns backup/
cp -r /etc/cybervpn/limit/noobs backup/
cp -r /etc/cybervpn/limit/sstp backup/
cp -r /etc/cybervpn/limit/l2tp backup/

# data
cp -r /root/regis backup/
cp -r /var/lib/kyt/ backup/kyt
cp -r /var/lib/cybervpn/ backup/cybervpn
cp -r /var/lib/cyber/ backup/cyber
cp -r /etc/xray backup/xray
cp -r /var/www/html/ backup/html

cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
" | mail -s "Backup Data" $email
rm -rf /root/backup
rm -r /root/$IP-$date.zip
clear
CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
TEXT="<code>==============</code>
<code>Detail Backup </code>
<code>==============</code>
<code>DOMAIN       : ${domain}</code>
<code>==============</code>
<code>IP VPS       : ${IP}</code>
<code>==============</code>
<code>Link Backup   :</code> $link
<code>==============</code>
<code>Tanggal : $date</code>
<code>==============</code>
<code>Silahkan copy Link dan restore di VPS baru</code>
"
curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
echo ""
clear
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
Domain        : $domain
==================================
"
echo "Silahkan copy Link dan restore di VPS baru"
echo ""


}

function Restor_Via() {
clear
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
CHATID=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)
KEY=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
function notif_restore() {
    green "Notif AddHost Tele"
    sleep 2
    CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
TEXT="
<code>◇━━━━━━━━━━━━━━◇</code>
<b>  ⚠️ RESTORE NOTIF⚠️</b>
<b>     Detail Restore VPS</b>
<code>◇━━━━━━━━━━━━━━◇</code>
<code>Restore Vps Done</code>
<code>◇━━━━━━━━━━━━━━◇</code>
<code>BY BOT : @Lunatic</code>
"

curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
# ==========================================
# Getting
clear
echo -e "\e[35;1m # ================================ # \e[0m"
echo -e ""
echo -e "\e[93;1m      MASUKAN LINK BACKUP \e[0m"
echo -e ""
echo -e "\e[35;1m # ================================ # \e[0m"
echo -e ""
read -rp "Link File: " -e url
wget -O backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo Start Restore
cd /root/backup
cp passwd /etc/
cp group /etc/
cp shadow /etc/
cp gshadow /etc/
cp crontab /etc/

cp -r kyt /var/lib/
cp -r cyber /var/lib/
cp -r cybervpn /var/lib
cp -r lunatic /var/lib
cp -r xray /etc/
cp -r html /var/www/

# copy Data Db Akun
cp .ssh.db /etc/ssh/
cp .vmess.db /etc/vmess/
cp .vless.db /etc/vless/
cp .trojan.db /etc/trojan/
cp .shadowsocks.db /etc/shadowsocks/
cp .noobzvpns.db /etc/noobzvpns/
cp .sstp.db /etc/sstp/
cp .l2tp.db /etc/l2tp/
cp .bot.db /etc/bot/

# copy data Db dir Lunatic
cp .ssh.db /etc/lunatic/ssh/
cp .vmess.db /etc/lunatic/vmess/
cp .vless.db /etc/lunatic/vless/
cp .trojan.db /etc/lunatic/trojan/
cp .shadowsocks.db /etc/lunatic/shadowsocks/
cp .noobzvpns.db /etc/lunatic/noobzvpns/
cp .sstp.db /etc/lunatic/sstp/
cp .l2tp.db /etc/lunatic/l2tp/
cp .bot.db /etc/lunatic/bot/

cp -r limit /etc/cybervpn/
cp -r vmess /etc/cybervpn/limit/
cp -r vless /etc/cybervpn/limit/
cp -r trojan /etc/cybervpn/limit/
cp -r shadowsocks /etc/cybervpn/limit/
cp -r noobzvpns /etc/cybervpn/limit/
cp -r sstp /etc/cybervpn/limit/
cp -r l2tp /etc/cybervpn/limit/


cp -r regis /root/
notif_restore
rm -rf /root/backup
rm -f backup.zip
echo ""

}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m          BACKUP LIBEV             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [01] • BACKUP VPS DATA \e[0m"
echo -e "\e[37;1m [02] • RESTOR VPS DATA \e[0m"
echo -e "\e[37;1m [03] • AUTO BACKUP VPS \e[0m"
echo -e "\e[37;1m [04] • SETTING BR \e[0m"
echo -e "\e[37;1m [05] • BACKUP VIA GDRIVE \e[0m"
echo -e "\e[37;1m [06] • RESTOR VIA GDRIVE \e[0m"
echo -e "\e[31;1m [00] • GO BACK         \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;91;1m       ARJUN VPN TUNELING          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Just Input :  "  bro
case $bro in
1) clear ; Backup_Vps ;;
2) clear ; Restor_Vps ;;
3) clear ; m-abk ;;
4) clear ; Set_Br ;;
5) clear ; Gdrive_Via ;;
6) clear ; Restor_Via ;;
esac