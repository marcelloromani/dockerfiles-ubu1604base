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

RUN adduser --system --ingroup sudo --shell /bin/bash admin
RUN echo "admin:admin" | chpasswd
COPY files/motd /etc/motd
RUN echo "cat /etc/motd" >> /etc/bash.bashrc

COPY files/sudoers_admin /etc/sudoers.d/admin

WORKDIR /home/admin

RUN mkdir .ssh
COPY files/id_rsa .ssh/
COPY files/id_rsa.pub .ssh/
COPY files/id_rsa.pub .ssh/authorized_keys
RUN chown -R admin .ssh
RUN chmod 600 .ssh/id_rsa
RUN chmod 644 .ssh/id_rsa.pub
RUN chmod 644 .ssh/authorized_keys

COPY files/show_credentials.sh .
RUN chmod 755 show_credentials.sh

USER admin
EXPOSE 22

CMD ["/bin/bash"]
