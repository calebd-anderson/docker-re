# FROM ubuntu:latest
# RUN echo "deb http://security.ubuntu.com/ubuntu focal-security main universe" > /etc/apt/sources.list.d/ubuntu-focal-sources.list
FROM ubuntu:22.04
RUN dpkg --add-architecture i386
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install -y wine gdb gdb-mingw-w64 gdb-mingw-w64-target gdbserver
# install debuggers
RUN apt install -y gcc build-essential libc6:i386 libncurses5:i386 libstdc++6:i386 libc6-dev gcc-multilib
# install apps then prevent the cached apt lists (which are fetched by apt update) from ending up in the container image
RUN apt install -y openssh-server vim file bsdmainutils less make python3 git sudo unzip zip python3-pip python3-dev libssl-dev libffi-dev && rm -rf /var/lib/apt/lists/*
# allow ssh login
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
ARG username=user1
RUN useradd -m -s /bin/bash $username
RUN echo -n "${username}:secret" | chpasswd
RUN usermod -aG sudo $username
# install radare2 (requires sudo)
RUN cd /tmp && git clone https://github.com/radareorg/radare2
RUN /tmp/radare2/sys/install.sh
# install pwntools
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pwntools
ENTRYPOINT ["/entrypoint.sh"]
RUN mkdir /run/sshd
EXPOSE 22 
COPY entrypoint.sh /
