
# FROM base-ansible
#
# WORKDIR /app
#
# COPY . .

# RUN ansible-playbook local.yml

FROM archlinux

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm ansible git sudo vim which

RUN useradd -mG wheel scrythe

# RUN %wheel ALL=(ALL:ALL) ALL

RUN echo scrythe:123 | chpasswd

RUN sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

USER scrythe

WORKDIR /home/scrythe/ansible

COPY . .

RUN ansible-playbook local.yml -e "user=$(whoami) ansible_sudo_pass=123" -t "zsh,dotfiles"

# RUN ansible-playbook local.yml -e user=scrythe -K
