#!/bin/bash

apt update && apt install -y dnsmasq pxelinux syslinux-common syslinux-efi apache2 wget


cp -r ./tftpboot /
cp fix-permissions.sh /tftpboot
mkdir -p /tftpboot/boot/bios/ /tftpboot/boot/efi64/


# BIOS
ln -s /tftpboot/boot/pxelinux.cfg /tftpboot/boot/bios/
ln -s /usr/lib/PXELINUX/lpxelinux.0 /tftpboot/boot/bios/
ln -s /usr/lib/syslinux/modules/bios/ldlinux.c32 /tftpboot/boot/bios/
for f in `ls /usr/lib/syslinux/modules/bios/*.c32`;
do
    ln -s $f /tftpboot/boot/bios/
done
ln -s /tftpboot/boot/de.ktl /tftpboot/boot/bios/
ln -s /tftpboot/hdt /tftpboot/boot/bios/
ln -s /tftpboot/sysresccd /tftpboot/boot/bios/
ln -s /tftpboot/clonezilla /tftpboot/boot/bios/


# (U)EFI x64
ln -s /tftpboot/boot/pxelinux.cfg /tftpboot/boot/efi64/
ln -s /usr/lib/SYSLINUX.EFI/efi64/syslinux.efi  /tftpboot/boot/efi64/
ln -s /usr/lib/syslinux/modules/efi64/ldlinux.e64 /tftpboot/boot/efi64/
for f in `ls /usr/lib/syslinux/modules/efi64/*.c32`;
do
    ln -s $f /tftpboot/boot/efi64/
done
ln -s /tftpboot/boot/de.ktl /tftpboot/boot/efi64/
ln -s /tftpboot/hdt /tftpboot/boot/efi64/
ln -s /tftpboot/sysresccd /tftpboot/boot/efi64/
ln -s /tftpboot/clonezilla /tftpboot/boot/efi64/


# fix permissions
find /tftpboot -type f -print0 | xargs -0 chmod 644
find /tftpboot -type d -print0 | xargs -0 chmod 755


# for HTTP downloading
ln -sf /tftpboot/sysresccd /var/www/html/
ln -sf /tftpboot/clonezilla /var/www/html/


# dnsmasqd
mv -f /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
cp -f ./dnsmasq.conf /etc/dnsmasq.conf
systemctl restart dnsmasq

echo "--------------------------------------------"
echo "Adjust /etc/dnsmasq.conf to match your IP subnet"
echo "1. Adjust /tftpboot/boot/pxelinux.cfg/default: http://<YOUR IP>/..."
echo "3. Prepare SystemRescue (see README.md!)"
echo "4. (Optional) prepare Clonezilla (see README.md!)"
echo "5. Adjust permissions, use fix-persmissions.sh"
echo "--------------------------------------------"

