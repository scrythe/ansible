# pacman -Syu --noconfirm

# pacman -S base base-devel linux linux-firmware networkmanager vim
# pacman -S --noconfirm ansible git sudo vim

# passwd
#
useradd -m -G wheel scrythe

passwd scrythe

vim /etc/sudoers

# ansible-playbook local.yml -e "user=$(whoami)" -K
