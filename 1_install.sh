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
