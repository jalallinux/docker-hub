## Container must be privileged
```
docker run --name ubuntu-20.04 --hostname=ubuntu --tty --net=host -d --privileged jalallinux/dind:ubuntu-20.04
```

```yml
version: "3.9"

services:
  os:
    image: jalallinux/dind:ubuntu-20.04
    container_name: ubuntu-20.04
    hostname: ubuntu
    privileged: true
    tty: true
    extra_hosts:
      - "host.docker.internal:host-gateway"
    network_mode: host
```

## After making container start docker service:
```shell
service docker start
```
