#!/bin/bash

docker rm -f my_head_final
docker rmi my_head:final
docker build -t my_head:final --add-host head:127.0.0.1 .
docker run -d --name my_head_final --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v torque:/home -p 7777:22 --hostname head --network torque --ip 172.20.0.95 --add-host compute01:172.20.0.94 my_head:final
docker exec -it my_head_final bash
