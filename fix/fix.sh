#!/bin/bash
mkdir /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp -r /etc/xray backup/xray
cp -r /var/www/html/ backup/html
cd /root
zip -r backup.zip backup > /dev/null 2>&1

rclone copy backup.zip dr:backup/
url=$(rclone link dr:backup/backup.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
linkbackup="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo $linkbackup >/tmp/link
rm -r backup && rm backup.zip
echo " Your link backup : "
echo "${linkbackup}"
