#!/bin/bash

echo "Set root password"
passwd

echo "Create a new user"
echo "Set username"
read username

useradd -m $username
passwd $username

usermod -aG wheel $username
pacman -S sudo neovim lvm2 grub

echo "wheel ALL=(ALL:ALL)" | sudo EDITOR="tee -a" visudo
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "127.0.0.1 localhost" > /etc/hosts
locale-gen

systemctl enable NetworkManager
ln -sf /usr/share/zoneinfo/Mexico/General /etc/localtime
hwclock --systohc
mkinitcpio -P
grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

pacman -Sy archlinux-keyring && pacman -Su
pacman -S openssh zsh kitty xorg xf86-video-intel gnome gnome-extra gnome-tweak-tool gdm gnome-shell-extensions
systemctl enable gdm
exit
umount -R /mnt
shutdown -r now
