# Reverse engineering in Docker

This projects holds a Docker container configured with reverse engineering tooling.

## Build the container

```
docker build -t ubuntu:re --build-arg username=<username> .
```

## Container Security

- [Docker Security](https://docs.docker.com/engine/security/)
- [runtime-privilege-and-linux-capabilities](https://docs.docker.com/engine/containers/run/#runtime-privilege-and-linux-capabilities)
- [seccomp](https://docs.docker.com/engine/security/seccomp/)
- [security non-events](https://docs.docker.com/engine/security/non-events/)

> [!CAUTION]
> To allow dynamic analysis we must enable a sys call on the container:
> - Linux capability: `--cap-add=SYS_PTRACE`
> - Kernel seccomp profile: `--security-opt seccomp=unconfined`

> [!TIP]
> Avoid the [`--privileged flag`](https://docs.docker.com/reference/cli/docker/container/run/#privileged) as it basically disables all security.

## Start the container

```sh
# basic container
docker run -v ~/workdir:/home/<username> --security-opt seccomp=unconfined --cap-add=SYS_PTRACE -d --rm --name reverseme ubuntu:re
```

### Remote Debugging (dynamic analysis)

```sh
# with open ports for remote analysis
docker run --security-opt seccomp=unconfined --cap-add=SYS_PTRACE -d --rm --name reverseme -p 12345:12345 -p 7655:22 ubuntu:re
# instead copy an executable to the container
docker cp "<path-to>/<executable>" reverseme:/tmp
# start the remote debugger pointing to the copied executable
docker exec reverseme gdbserver localhost:12345 /tmp/<executable>
# debug from the host
gdb -ex "target extended-remote :12345"
```

### Enter the container

```
docker exec -ti reverseme /bin/bash -c 'cd /home/<username> && /bin/bash'
```

## More Information

- [remnux-containers](https://docs.remnux.org/run-tools-in-containers/remnux-containers)
- [pwntools](https://github.com/Gallopsled/pwntools)
- [radare2](https://github.com/radareorg/radare2)
- [Docker Containers for Malware Analysis](https://zeltser.com/media/archive/docker.pdf)
