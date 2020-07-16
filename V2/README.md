
## Initial setup

The first thing we are going to do is create a network for jupyterhub to use.

```bash
docker network create jupyterhub
```

Second, we are going to build our hub image:

```bash
docker build -t hub .
```

We also want to pull the image that will be used:

```bash
docker pull jupyter/base-notebook
```

## Start the hub

To start the hub, we want to:

- run it on the docker network
- expose port 8000
- mount the host docker socket

```bash
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --net jupyterhub --name jupyterhub -p 8000:8000 hub
```

Now we should have jupyterhub running on port 8000 on our docker host.


