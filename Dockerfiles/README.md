There are three versions of jupyterhub setup that we have made

**V1- Jupyterhub with Linux user spawner**

-Using linux user authentication and spawning users in home directory of respective linux user

**V2-Jupyterhub with dockerspawner with Linux authenticator**

Using linux user authentication and spawning users in individual docker containers.

**V3-Jupyterhub with dockerspawner and Native Authenticator.**

-providing support to inbuilt authentication without being dependent on linux authentication and spawning users in individual docker containers.
