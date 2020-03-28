#!/usr/bin/env bash

set -euo pipefail

echo "Installing packages"
SYSTEM="base linux e2fsprogs dosfstools systemd-resolvconf openssh reflector irqbalance"
GUEST_UTILS="virtualbox-guest-utils-nox virtualbox-guest-modules-arch"
UCODE="amd-ucode intel-ucode"
UTILS="vim wget curl man sudo"
SHELL="zsh grml-zsh-config"
PACKAGES="$SYSTEM $GUEST_UTILS $UCODE $UTILS $SHELL"
pacstrap /mnt $PACKAGES

echo "Generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab
sed -i -E '/\/boot/ s/(rw,\S*)/\1,noauto,x-systemd.automount/' /mnt/etc/fstab
