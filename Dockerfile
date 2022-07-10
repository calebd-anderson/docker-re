FROM ubuntu:latest
RUN dpkg --add-architecture i386
RUN apt update && apt upgrade -y
RUN apt install --no-install-recommends --assume-yes wine gdb gdb-mingw-w64 gdb-mingw-w64-target gdbserver gcc openssh-server vim file libc6:i386 libncurses5:i386 libstdc++6:i386 libc6-dev gcc-multilib bsdmainutils less
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN useradd -m -s /bin/bash caleb
RUN echo -n 'caleb:secret' | chpasswd 
ENTRYPOINT ["/entrypoint.sh"] 
RUN mkdir /run/sshd
EXPOSE 22 
COPY entrypoint.sh /
ENV DISPLAY :0
