FROM ubuntu:16.04

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV XDG_RUNTIME_DIR /run/user/$(id -u)

#for enable systemd
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
	useradd -ms /bin/bash cdac && \
	echo 'cdac:cdac@123' | chpasswd

RUN cd / && \
	git clone https://github.com/adaptivecomputing/torque.git -b 6.0.1 6.0.1 && \
	cd /6.0.1 && \
	./autogen.sh && \
	./configure && \
	make && \
	make install

COPY nodes /var/spool/torque/server_priv/

RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/torque.conf && \
	ldconfig && \
	cd /6.0.1 && \
	cp contrib/systemd/trqauthd.service /etc/systemd/system && \
	systemctl enable trqauthd.service && \
	cp contrib/systemd/pbs_server.service /etc/systemd/system/ && \
	systemctl enable pbs_server.service && \
	cp contrib/systemd/pbs_sched.service /etc/systemd/system/ && \
	systemctl enable pbs_sched.service

RUN echo head > /var/spool/torque/server_name


RUN cd 6.0.1 && \
	yes | ./torque.setup root


VOLUME [ "/sys/fs/cgroup" ]

COPY nodes /var/spool/torque/server_priv/

RUN mkdir -p /etc/systemd/system/default.target.wants && \  
	systemctl enable systemd-user-sessions.service && \
	ln -s /usr/lib/systemd/system/systemd-user-sessions.service /etc/systemd/system/default.target.wants/systemd-user-sessions.service && \
	apt-get -y install openssh-server && \
	systemctl enable ssh && \
	echo "\nUserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
	echo "\nStrictHostKeyChecking no " >> /etc/ssh/ssh_config

COPY ssh_keys /home/cdac/.ssh


ENTRYPOINT ["/lib/systemd/systemd"]

