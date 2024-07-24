
# FROM base-ansible
#
# WORKDIR /app
#
# COPY . .

# RUN ansible-playbook local.yml

FROM archlinux

WORKDIR /app

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm ansible git sudo

COPY . .

# RUN ansible-playbook local.yml -t zsh
