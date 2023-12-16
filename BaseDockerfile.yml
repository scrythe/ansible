FROM fedora

WORKDIR /app

RUN dnf install -y ansible git

COPY . .

RUN ansible-playbook local.yml
