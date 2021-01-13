FROM continuumio/anaconda3:latest

RUN mkdir -p /srv/data/my_shared_data_folder && \
        ln -s /srv/data/my_shared_data_folder /etc/skel/my_shared_data_folder && \
        mkdir -p /srv/jupyterhub/git && \
        apt-get update && \
        apt-get -y install gcc && \
        apt-get -y install g++ && \
        apt-get -y install git

COPY jupyterhub_config.py /srv/jupyterhub/

RUN conda install -c conda-forge jupyterhub && conda install notebook

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

WORKDIR /srv/jupyterhub/

EXPOSE 8000

#CMD ["jupyterhub"]

#CMD ["",""]

ENTRYPOINT [ "jupyterhub" ]
