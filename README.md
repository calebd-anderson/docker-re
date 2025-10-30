# Reverse engineering in Docker
This projects holds a Docker container configured with some great reverse engineering tools and greater security enabled for malware analysis.
## Build the container
```
docker build -t ubuntu:re --build-arg username=<username> .
```
## Start the container with some security
```sh
# basic container with a volume pointing to the host
docker run -v ~/workdir:/home/<username> --privileged --security-opt seccomp=unconfined --cap-add=SYS_PTRACE -d --rm --name reverseme ubuntu:re
```
### Remote Debugging (analysis)
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
