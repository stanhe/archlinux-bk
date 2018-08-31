#!/bin/bash
echo "==> format and mount disk:"
mkswap /dev/sda6
swapon /dev/sda6
mkfs.ext4 /dev/sda5
mkfs.ext4 /dev/sda7
mkfs.ext4 /dev/sda8
mkfs.ext4 /dev/sda9
mount /dev/sda5 /mnt 
mkdir /mnt/boot
mount /dev/sda7 /mnt/boot
mkdir /mnt/var
mount /dev/sda8 /mnt/var
mkdir /mnt/home
mount /dev/sda9 /mnt/home
echo "==> set config:"
# No need 163 mirrors
#sed -i "2iServer = http://mirrors.163.com/archlinux/$repo/os/$arch" /etc/pacman.d/mirrorlist 
#echo -e "#auto update pacman!\n[archlinuxcn]\nSigLevel = Optional TrustedOnly \nServer = http://mirrors.163.com/archlinux-cn/\$arch" | tee -a /etc/pacman.conf
timedatectl set-ntp true
ping -c 1 archlinux.org
pacman -Syy
pacman -S archlinux-keyring 
pacstrap -i /mnt base base-devel 
genfstab -U /mnt >> /mnt/etc/fstab
echo """
trap \"rm -rf stan-config.sh\" INT EXIT
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --utc
echo -e \"\nen_US.UTF-8 UTF-8\nzh_CN.UTF-8 UTF-8\" | tee -a /etc/locale.gen
echo -e \"LANG=en_US.UTF-8\" | tee /etc/locale.conf
locale-gen
echo stanhe > /etc/hostname
useradd -m -G wheel stan
echo -e \"==> input the root passwd:\"
passwd root
echo -e \"==> input stan's passwd:\"
passwd stan
echo \"==> install grub:\"
pacman -S grub os-prober 
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable dhcpcd.service
exit
""" > /mnt/stan-config.sh
chmod +x /mnt/stan-config.sh
arch-chroot /mnt ./stan-config.sh
umount -R /mnt
echo "========== finish install system =========="
sleep 3
reboot
