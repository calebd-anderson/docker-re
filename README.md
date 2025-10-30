# Reverse engineering in Docker
This projects holds a Docker container configured with some great reverse engineering tools and greater security enabled for malware analysis.
## Build the container
```
docker build -t ubuntu:re --build-arg username=<username> .
```
## Start the container with some security
```
docker run -v ~/workdir:/home/<username> --privileged --security-opt seccomp=unconfined --cap-add=SYS_PTRACE -d --rm --name reverseme ubuntu:re
```
## Enter the container
```
docker exec -ti reverseme /bin/bash -c 'cd /home/<username> && /bin/bash'
```
### More Information
- [remnux-containers](https://docs.remnux.org/run-tools-in-containers/remnux-containers)
- [pwntools](https://github.com/Gallopsled/pwntools)
- [radare2](https://github.com/radareorg/radare2)
