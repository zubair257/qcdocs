#!/bin/bash

docker rm -f my_compute_finalb
docker rmi my_compute:finalb
docker build -t my_compute:finalb .
docker run -d --name my_compute_finalb --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v torque:/home -p 8888:22 --hostname compute01 --network torque --ip 172.20.0.94 --add-host head:172.20.0.95 my_compute:finalb
docker exec -it my_compute_finalb bash
