#!/bin/bash

[[ -f /tftpboot/boot/wimboot ]] || wget -O /tftpboot/boot/wimboot "https://github.com/ipxe/wimboot/releases/latest/download/wimboot"

ln -s /tftpboot/boot/wimboot /tftpboot/boot/bios/
ln -s /tftpboot/boot/wimboot.ipxe /tftpboot/boot/bios/
ln -s /tftpboot/boot/ipxe.lkrn /tftpboot/boot/bios/

ln -s /tftpboot/boot/wimboot /tftpboot/boot/efi64/
ln -s /tftpboot/boot/wimboot.ipxe /tftpboot/boot/efi64/
ln -s /tftpboot/boot/ipxe.lkrn /tftpboot/boot/efi64/

cp -r ./var/www/html/win10/ /var/www/html/
ln -s /tftpboot/boot/wimboot /var/www/html/win10/

cat << EOF

=====================================================================

Next: 

1. copy from MS Windows ISO to /var/www/html/win10/
  /var/www/html/win10/boot/bcd
  /var/www/html/win10/boot/boot.sdi
  /var/www/html/win10/sources/boot.wim

2. chmod -R ugo+rX /var/www/html/win10/

3. uncomment iPXE/WIMBoot in
  /tftpboot/boot/pxelinux.cfg/default

4. adjust IP in 
  /tftpboot/boot/wimboot.ipxe

This will allow to PXE/iPXE boot to the Windows-Install menu, 
HOWEVER only the computer repair mode does works, 
the actual install mode *does not work* (missing drivers, unsolved).

=====================================================================

EOF
