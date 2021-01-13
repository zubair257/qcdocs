**Step 1** : build the docker image by using the following command.

$ docker build -t jupyterhub .

**Step 2:**

It will create around 3 Gb of docker image with all the configurations and environment setup required.

$ docker run -p 8000:8000 -d --name jupyterhub jupyterhub

**Step 3:**

Go to the following address and login with credentials provided in dockerfile

[http://localhost:8000](http://localhost:8000/)

**Username: cdac**

**Password: asdf**

Both Qiskit and Qiskit aakash have been installed in different environments of anaconda.

As cdac is configured as an admin user it can create and remove users from the admin panel.
