#!/bin/bash

#### Create squashfs
mkdir -p liveiso/boot || true
# For better installation time
#mksquashfs chroot filesystem.squashfs -comp gzip -wildcards
# For better compress ratio
mksquashfs chroot filesystem.squashfs -comp xz -wildcards

mkdir -p liveiso/live || true
#ln -s live liveiso/casper || true #for ubuntu 
mv filesystem.squashfs liveiso/live/filesystem.squashfs

#### Copy kernel and initramfs (Debian/Devuan)
cp -pf chroot/boot/initrd.img-* liveiso/boot/initrd.img
cp -pf chroot/boot/vmlinuz-* liveiso/boot/vmlinuz

#### Write grub.cfg
mkdir -p liveiso/boot/grub/
echo 'menuentry "Canli GNU/Linux 64-bit" --class liveiso {' > liveiso/boot/grub/grub.cfg
echo ' linux /boot/vmlinuz boot=live locales=tr_TR.UTF-8,en_US.UTF-8 keyboard-layouts=tr username=etahta hostname=tahta user-fullname=etahta noswap quiet live-config --' >> liveiso/boot/grub/grub.cfg
#echo '    linux /boot/vmlinuz boot=live quiet live-config --' >> liveiso/boot/grub/grub.cfg
echo '    initrd /boot/initrd.img' >> liveiso/boot/grub/grub.cfg
echo '}' >> liveiso/boot/grub/grub.cfg

#echo 'menuentry "Yukle (sda Diskli Faz-1-2-3`ler) GNU/Linux 64-bit" --class liveiso {' >> liveiso/boot/grub/grub.cfg
#echo '    linux /boot/vmlinuz boot=live quiet init=/usr/bin/installersd --' >> liveiso/boot/grub/grub.cfg
#echo '    initrd /boot/initrd.img' >> liveiso/boot/grub/grub.cfg
#echo '}' >> liveiso/boot/grub/grub.cfg

#echo 'menuentry "Yukle (nvme Diskli Faz-3`ler) GNU/Linux 64-bit" --class liveiso {' >> liveiso/boot/grub/grub.cfg
#echo '    linux /boot/vmlinuz boot=live quiet init=/usr/bin/installernvme --' >> liveiso/boot/grub/grub.cfg
#echo '    initrd /boot/initrd.img' >> liveiso/boot/grub/grub.cfg
#echo '}' >> liveiso/boot/grub/grub.cfg

echo 'menuentry "Yukle GNU/Linux 64-bit" --class liveiso {' >> liveiso/boot/grub/grub.cfg
echo '    linux /boot/vmlinuz boot=live quiet init=/usr/bin/installernvme --' >> liveiso/boot/grub/grub.cfg
echo '    initrd /boot/initrd.img' >> liveiso/boot/grub/grub.cfg
echo '}' >> liveiso/boot/grub/grub.cfg

#echo 'menuentry "Installer Graphic Screen GNU/Linux 64-bit" --class liveiso {' >> liveiso/boot/grub/grub.cfg
#echo '    linux /boot/vmlinuz boot=live username=liveinstall quiet --' >> liveiso/boot/grub/grub.cfg
#echo '    initrd /boot/initrd.img' >> liveiso/boot/grub/grub.cfg
#echo '}' >> liveiso/boot/grub/grub.cfg

#### Create iso
grub-mkrescue liveiso -o liveiso-gnulinux-$(date +%s).iso
