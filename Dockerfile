FROM fedora

WORKDIR /app

RUN dnf install -y ansible

COPY ../ ./
