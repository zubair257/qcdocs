# Setup Head node:



Run the Following commands to setup the Head node

##### Build the Docker image from Dockerfile:

```bash
docker build -t head_image --add-host head:127.0.0.1 .
```

##### Create and start docker container for the first time:

```bash
docker run -d --name my_head --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v torque_home:/home -p 7777:22 --hostname head --network torque_network --ip 172.20.0.95 --add-host compute01:172.20.0.94 head_image
```

##### Exec a new process to enter into container

```bash
docker exec -it my_head bash
```

