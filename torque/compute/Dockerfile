FROM ubuntu:16.04

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV XDG_RUNTIME_DIR /run/user/$(id -u)
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

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
	systemctl enable ssh && \
	echo "\nUserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
	echo "\nStrictHostKeyChecking no " >> /etc/ssh/ssh_config

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion && \
    apt-get clean

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.7.12-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

RUN conda create --name env_iisc python=3.7 && \
	conda create --name env_qiskit python=3.7 && \
	conda create --name env_python3.7 python=3.7 && \
	. /opt/conda/etc/profile.d/conda.sh && \
	conda activate env_iisc && \
	mkdir -p  /srv/jupyterhub/git && \
	cd /srv/jupyterhub/git && \
	git clone https://github.com/indian-institute-of-science-qc/qiskit-aakash.git && \
	cd qiskit-aakash && \
	pip install -e . && \
	conda activate env_qiskit && \
	pip install qiskit



VOLUME [ "/sys/fs/cgroup" ]


ENTRYPOINT ["/lib/systemd/systemd"]
