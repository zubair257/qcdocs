FROM ubuntu:16.04

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV XDG_RUNTIME_DIR /run/user/$(id -u)

RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y systemd systemd-sysv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp*


RUN apt-get update && \
	apt-get install -y libtool libssl-dev libxml2-dev libboost-all-dev gcc g++ git m4 automake pkg-config && \
	useradd -Ms /bin/bash cdac && \
	echo 'cdac:cdac@123' | chpasswd

# RUN cd / && \
#	git clone https://github.com/adaptivecomputing/torque.git -b 6.0.1 6.0.1 && \
#	cd /6.0.1 && \
#	./autogen.sh && \
#	./configure && \
#	make && \
#	make install

COPY packages/pbs_mom.service /etc/systemd/system/
COPY packages/torque-package-mom-linux-x86_64.sh /
COPY packages/torque-package-clients-linux-x86_64.sh /
RUN ./torque-package-mom-linux-x86_64.sh --install && \
	./torque-package-clients-linux-x86_64.sh --install
COPY packages/torque.conf /etc/ld.so.conf.d/
RUN /sbin/ldconfig && echo head > /var/spool/torque/server_name && systemctl enable pbs_mom.service

RUN mkdir -p /etc/systemd/system/default.target.wants && \  
	systemctl enable systemd-user-sessions.service && \
	ln -s /usr/lib/systemd/system/systemd-user-sessions.service /etc/systemd/system/default.target.wants/systemd-user-sessions.service && \
	apt-get -y install openssh-server && \
	systemctl enable ssh




VOLUME [ "/sys/fs/cgroup" ]


ENTRYPOINT ["/lib/systemd/systemd"]
