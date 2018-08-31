#!/bin/bash
# No need 163 mirrors
#echo -e "#auto update pacman!\n[archlinuxcn]\nSigLevel = Optional TrustedOnly \nServer = http://mirrors.163.com/archlinux-cn/\$arch" | sudo tee -a /etc/pacman.conf
#trap \"rm -rf ~/rollback-arch\" INT 
timedatectl set-ntp true
echo -e "\n======> update locale.gen:\n"
echo -e "#auto set local!\nzh_CN.GB18030 GB18030\nzh_CN.GBK GBK\nzh_CN GB2312" | sudo tee -a /etc/locale.gen
sudo locale-gen
echo -e "\n======> install yaourt:\n"
sudo pacman -Syu yaourt
#sudo pacman -S archlinuxcn-keyring
sudo pacman -S archlinux-keyring
echo -e "\n======> install zsh git :\n"
sudo pacman -S zsh git
echo -e "\n======> install Vundle and oh-my-zsh and emacs config <======\n"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/stanhe/emacs.d.git ~/.emacs.d
echo -e "\n======> please input your login passwd:\n"
chsh -s /bin/zsh
echo -e "\n======> please input your bitbucket passwd:\n"
git clone https://stanhe@bitbucket.org/natsho/archlinux-config.git ./arch
cp -rf arch/. ~/
rm -rf ~/arch
echo -e "========== finish =========="
echo -e "==> restart system after 3 seconds."
echo -e "==> after restart run: bksys"
sleep 3s
sudo reboot
