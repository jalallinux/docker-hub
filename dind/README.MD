## Container must be privileged
```
docker run --name ubuntu-20.04 --hostname=ubuntu --tty --net=host -d --privileged jalallinux/dind:ubuntu-20.04
```

## After making container start docker service:
```shell
service docker start
```
