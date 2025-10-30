FROM alpine:latest
RUN apk add --update --no-cache openssh
RUN apk add vim file binutils libc6-compat gcc gdb musl-dev python3
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN adduser -h /home/caleb -s /bin/sh -D caleb
RUN echo -n 'root:***REMOVED***' | chpasswd
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY entrypoint.sh /
