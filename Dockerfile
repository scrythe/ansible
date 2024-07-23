# FROM base-ansible
#
# WORKDIR /app
#
# COPY . .
#
# RUN ansible-playbook local.yml -t zsh

FROM archlinux

WORKDIR /app

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm ansible git

COPY . .

# RUN ansible-playbook local.yml -t zsh
