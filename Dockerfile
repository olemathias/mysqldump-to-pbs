FROM debian:bullseye-slim

WORKDIR /app

RUN apt update && apt install -y wget lsb-release gnupg && wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg
RUN echo "deb http://download.proxmox.com/debian/pbs-client bullseye main" > /etc/apt/sources.list.d/pbs.list && apt update
RUN apt install -y proxmox-backup-client default-mysql-client

COPY startup.sh startup.sh

CMD ["sh", "startup.sh"]
