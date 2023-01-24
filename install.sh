#!/bin/bash

echo "Select disk to install"
lsblk | grep "disk"
read disk

timedatectl set-ntp true

parted /dev/$disk mklabel gpt
parted -a optimal /dev/$disk mkpart ESP fat32 1MiB 513MiB
parted /dev/$disk set 1 boot on
parted /dev/$disk name 1 efi
parted -a optimal /dev/$disk mkpart primary 513MiB 800MiB
parted /dev/$disk name 2 boot
parted -a optimal /dev/$disk mkpart primary 800MiB 100%
parted /dev/$disk name 3 lvm-partition
parted /dev/$disk set 3 lvm on

pvcreate /dev/$disk[3]
vgcreate arch-lvm /dev/$disk[3]
lvcreate -n root -l 100%FREE arch-lvm
mkfs.fat -F32 /dev/$disk[1]
mkfs.ext4 /dev/$disk[2]
mkfs.btrfs -L root /dev/arch-lvm/root

mount /dev/arch-lvm/root /mnt
mkdir /mnt/boot
mount /dev/$disk[2] /mnt/boot
mkdir /mnt/boot/efi
mount /dev/$disk[1] /mnt/boot/efi

pacstrap /mnt base base-devel linux linux-firmware efibootmgr btrfs-progs networkmanager network-manager-applet linux-headers mtools xdg-user-dirs --noconfirm

genfstab -U -p /mnt > /mnt/etc/fstab



cat > /mnt/etc/mkinitcpio.conf << EOF
#     MODULES=(piix ide_disk reiserfs)
MODULES=()

BINARIES=()

FILES=()
HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)  
EOF


arch-chroot /mnt

cat > /mnt/arch2.txt << EOF
#! /bin/bash
yes | pacman -S networkmanager
yes | pacman -S lvm2
systemctl enable NetworkManager
ln -sf /usr/share/zoneinfo/Mexico/General /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "127.0.0.1 localhost" > /etc/hosts
echo "kubexa.arch" > /etc/hostname
mkinitcpio -P
yes | pacman -S grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

echo "Set password root..."
passwd root

echo "Create a new user, set username"
read username

useradd -m $username
passwd $username

usermod -aG wheel $username

pacman -Sy archlinux-keyring && pacman -Su
pacman -Sy neovim openssh zsh kitty xorg xf86-video-intel gnome gnome-extra gnome-tweak-tool gdm gnome-shell-extensions
systemctl enable gdm
EOF


chmod +x /mnt/arch2.txt
arch-chroot /mnt /arch2.txt
rm -f /mnt/arch2.txt install.sh
shutdown -r now

