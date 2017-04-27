FROM ubuntu:16.04
RUN apt-get -qy update && \
    apt-get -qy install   \
    vim            \
    less           \
    net-tools      \
    iputils-ping   \
    host           \
    openssh-server \
    git            \
    tmux           \
    links2         \
    binutils       \
    sudo        && \
    apt-get -y autoremove

COPY files/motd /etc/motd
COPY files/sudoers_admin /etc/sudoers.d/admin

RUN adduser --system --ingroup sudo --shell /bin/bash admin \
 && echo "admin:admin" | chpasswd                           \
 && echo "cat /etc/motd" >> /etc/bash.bashrc

WORKDIR /home/admin

RUN mkdir .ssh
COPY files/id_rsa .ssh/
COPY files/id_rsa.pub .ssh/
COPY files/id_rsa.pub .ssh/authorized_keys
RUN chown -R admin .ssh            \
 && chmod 600 .ssh/id_rsa          \
 && chmod 644 .ssh/id_rsa.pub      \
 && chmod 644 .ssh/authorized_keys

USER admin
EXPOSE 22

CMD ["/bin/bash"]
