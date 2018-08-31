#!/bin/bash
echo -e "#auto update pacman!\n[archlinuxcn]\nSigLevel = Optional TrustedOnly \nServer=http://mirrors.163.com/archlinux-cn/\$arch" | sudo tee -a /etc/pacman.conf
sudo pacman -Syu yaourt
pacman -S archlinuxcn-keyring
sudo pacman -S zsh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh
git clone https://stanhe@bitbucket.org/natsho/archlinux-config.git ./arch
cp -rf arch/. ~/
git clone https://stanhe@bitbucket.org/stanhe/emacs.d.git ~/.emacs.d
echo -e "========== finish =========="
echo -e "==> restart system after 3 seconds."
echo -e "==> please restart and run: bksys."
sleep 3s
sudo reboot
