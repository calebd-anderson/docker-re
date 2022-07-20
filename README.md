# psychic-octo-barnacle-re
reverse engineering in docker
## use
- `docker build -t ubuntu:re .`  
- `docker run -v ~/workdir:/home/caleb --privileged --security-opt seccomp=unconfined --cap-add=SYS_PTRACE -d --rm --name reverseme ubuntu:re`  
- `docker exec -ti reverseme /bin/bash -c 'cd /home/caleb && /bin/bash'`
### also try
https://docs.remnux.org/run-tools-in-containers/remnux-containers
