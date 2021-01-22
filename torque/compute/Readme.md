# Compute node setup:

##### Build the docker image

```bash
docker build -t compute_image .
```

##### Create and run docker container

```bash
docker run -d --name my_compute --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v torque_home:/home -p 8888:22 --hostname compute01 --network torque_network --ip 172.20.0.94 --add-host head:172.20.0.95 compute_image
```

##### Exec a new process to enter the container

```bash
docker exec -it my_compute bash
```

