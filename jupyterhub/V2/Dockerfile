FROM jupyterhub/jupyterhub:0.9.4
COPY requirements.txt /tmp/requirements.txt
RUN python3 -m pip install --no-cache -r /tmp/requirements.txt
COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN mkdir -p /srv/data/my_shared_data_folder && \
        ln -s /srv/data/my_shared_data_folder /etc/skel/my_shared_data_folder && \
        mkdir -p /srv/jupyterhub/git && \
        apt-get update && \
        apt-get -y install gcc && \
        apt-get -y install g++ && \
        apt-get -y install git

RUN adduser --disabled-password --gecos "" cdac && \
        echo 'cdac:asdf' | chpasswd

RUN conda create --name ENV_A python=3.7 && \
        conda create --name ENV_B python=3.7 && \
        conda create --name ENV_C python=3.7 && \
        . /opt/conda/etc/profile.d/conda.sh && \
        conda activate ENV_A && \
        cd /srv/jupyterhub/git && \
        git clone https://github.com/indian-institute-of-science-qc/qiskit-aakash.git && \
        cd qiskit-aakash && \
        pip install -e . && \
        pip install ipykernel && \
        conda activate ENV_B && \
        pip install qiskit && \
        pip install ipykernel && \
        conda activate ENV_C && \
        pip install ipykernel && \
        /opt/conda/envs/ENV_A/bin/python -m ipykernel install --prefix=/usr/local/ --name 'ENV_A' && \
        /opt/conda/envs/ENV_B/bin/python -m ipykernel install --prefix=/usr/local/ --name 'ENV_B' && \
        /opt/conda/envs/ENV_C/bin/python -m ipykernel install --prefix=/usr/local/ --name 'ENV_C'
