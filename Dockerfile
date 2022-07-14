FROM ubuntu:latest
RUN dpkg --add-architecture i386
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install -y wine gdb gdb-mingw-w64 gdb-mingw-w64-target gdbserver
# install debuggers
RUN apt install -y gcc build-essential libc6:i386 libncurses5:i386 libstdc++6:i386 libc6-dev gcc-multilib
# install apps
# then prevent the cached apt lists (which are fetched by apt update) from ending up in the container image
RUN apt install -y openssh-server vim file bsdmainutils less make python3 git sudo && rm -rf /var/lib/apt/lists/*
# allow ssh login
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN useradd -m -s /bin/bash caleb
RUN echo -n 'caleb:secret' | chpasswd
RUN usermod -aG sudo caleb
RUN cd /tmp && git clone https://github.com/radareorg/radare2
RUN /tmp/radare2/sys/install.sh
ENTRYPOINT ["/entrypoint.sh"]
RUN mkdir /run/sshd
EXPOSE 22 
COPY entrypoint.sh /
ENV DISPLAY :0
