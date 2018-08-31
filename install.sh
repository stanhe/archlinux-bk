#!/bin/bash
echo "==> format and mount disk:"
mkswap /dev/sda6
swapon /dev/sda6
mkdir /mnt/boot
mkdir /mnt/var
mkdir /mnt/home
mkfs.ext4 /dev/sda5
mkfs.ext4 /dev/sda7
mkfs.ext4 /dev/sda8
mkfs.ext4 /dev/sda9
mount /dev/sda5 /mnt
mount /dev/sda7 /mnt/boot
mount /dev/sda8 /mnt/var
mount /dev/sda9 /mnt/home
echo "==> set config:"
sed -i "2ihttp://mirrors.163.com/archlinux/$repo/os/$arch" /etc/pacman.d/mirrorlist 
echo -e "#auto update pacman!\n[archlinuxcn]\nSigLevel = Optional TrustedOnly \nServer=http://mirrors.163.com/archlinux-cn/\$arch" | tee -a /etc/pacman.conf
pacman -Syy
pacman -S archlinuxcn-keyring
pacstrap -i /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
echo -e "\n en_US.UTF-8 UFT-8\nzh_CN.UTF-8 UTF-8" | tee -a /ect/locale.gen
locale-gen
echo stanhe > /etc/hostname
useradd -m -G wheel stan
echo "stan" | passwd --stdin
echo "==> install grub:"
pacman -S grub os-prober
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable dhcpcd.service
exit
umount -R /mnt
echo "========== finish install system =========="
sleep 3
reboot
