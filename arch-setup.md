# My Arch Setup

## Setup

set keyboard german keyboard layout

```
loadkeys de-latin1
# loadkezs deßlatin1
```

Check Boot Mode (64 for 64-bit x64 UEFI)

```
cat /sys/firmware/efi/fw_platform_size
```

check network interface listed and enabled

```
ip link
```

### connecting to internet over wifi

To get an interactive prompt

```
iwctl
```

list all Wi-Fi devices

```
device list
```

If the device or its corresponding adapter is turned off, turn it on

```
device name set-property Powered on
adapter adapter set-property Powered on
```

initiate a scan for networks (outputs nothing)

```
station name scan
```

then list all available networks

```
station name get-networks
```

to connect to a network

```
station name connect SSID
```

exit and check connection

```
exit
ping archlinux.org
```

### setting up ssh

setup password (just for install but not for root account in installation)

```
passwd
```

check status of ssh (usually active by default)

```
systemctl status sshd
```

if off

```
systemctl start sshd
```

get ip address (for wifi like previously done usually wlan0)

```
ip addr
```

connect with other pc

```
ssh root@ipaddress
```

ensure the system clock is synchronized (usually fine, timezone set later)

```
timedatectl
```

### Partitioning

#### Partition the disks

list block devices (if disk not shown, make sure disk controller is in raid mode)

```
fdisk -l
lsblk
```

modify partition tables with gdisk

```
gdisk /dev/the_disk_to_be_partitioned
```

print partition table with `p`  
create new partition with `n`  
list codes with `L` when prompted for code
to set size, use `+size(unit)` on last sector  
(for example `+300G`)

use `w` to save changes / write to disk

#### Formatting the partitions

For example formatting Linux filesystem to ext4

```
mkfs.ext4 /dev/root_partition
```

#### Mounting the filesystems

mount root volume to /mnt

```
mount /dev/root_partition /mnt
```

mount the EFI system partition and XBOOTLDR

```
mount --mkdir /dev/efi_system_partition /mnt/efi
mount --mkdir /dev/xbootldr_partition /mnt/boot
```

## Installation

installing the base package, Linux kernel and firmware for common hardware

```
pacstrap -K /mnt base linux linux-firmware
```

Generate an fstab file (use -U or -L to define by UUID or labels, respectively):

```
genfstab -U /mnt >> /mnt/etc/fstab
```

Change root into the new system:

```
arch-chroot /mnt
```

Installing base-devel for development and vim for editing

```
pacman -S base-devel vim
```

Set time zone

```
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

/etc/adjtime:

```
hwclock --systohc
```

edit `locale.gen` for localization and uncomment `en_US.UTF-8 UTF-8`

```
vim /etc/locale.gen
```

Generatating the locales

```
locale-gen
```

Create the locale.conf file, and set the LANG variable accordingly:

```
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

make console keyboard layout, changes persistent

```
echo KEYMAP=de-latin1 > /etc/vconsole.conf
```

Create the hostname file:

```
echo yourhostname > /etc/hostname
```

install networkmanager and enable it on startup

```
pacman -S networkmanager
systemctl enable NetworkManager
```

change password

```
passwd
```

create user and change its password

```
useradd -m -G wheel username
passwd username
```

install sudo and add wheel to sudoers group by
uncommenting `%wheel ALL=(ALL:ALL) ALL%`

```
pacman -S sudo
visudo
```

install ssh and enable it

```
pacman -S openssh
systemctl enable sshd
```

install linux-lts as failsave incase error

```
pacman -S linux-lts
```

checking GPU and looking up version
on https://www.nvidia.com/Download/driverResults.aspx/228545/en-us/

```
lspci -k | grep -A 2 -E "(VGA|3D)"
```

Installing GPU drivers for amd or intel

```
pacman -S mesa
```

TODO

Installing GPU drivers for nvidia  
idk if correct, also mine too old to be packaged for Arch Linux welp

```
pacman -S nvidia nvidia-utils nvidia-lts
```

Install package for hardware decoding for intel or amd (already inside nvidia)

```
pacman -S intel-media-driver
pacman -S libva-mesa-driver
```

installing microcode for amd or intel

```
pacman -S amd-ucode
pacman -S intel-ucode
```

TODO End

```
mkinitcpio -P
```

## Installing bootloader systemd-boot

all still while chrooted

ensure booted in UEFI mode (if direcotry exists, system is booted in UEFI mode)

```
ls /sys/firmware/efi/efivars
```

Use bootctl to install systemd-boot to the ESP

```
bootctl install
```

configuring systemd-boot (esp in this case efi)

```
vim esp/loader/loader.conf

#timeout 3
#console-mode keep
default arch.conf
timeout 0
```

exit, unmount all the partitions and restart the machine

```
exit
umount -R /mnt
reboot
```
