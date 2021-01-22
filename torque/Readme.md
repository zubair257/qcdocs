# Torque system setup:

provided package has two dockerfiles,

1.head

2.compute



setup the Prerequisites as shown below



## Prerequisites:

1.setup a network with subnet  defined



```bash
docker network create --subnet=172.20.0.0/16 torque_network

```



2.create a volume for sharing the /home across network.



```bash
docker volume create torque_home
```



setup the head and compute containers by  following the respective readmes'.