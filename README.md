# psychic-octo-barnacle-re
reverse engineering in docker  
`docker build -t ubuntu:re .`  
`docker run --security-opt seccomp=unconfined --cap-add=SYS_PTRACE -d --rm --name reverseme -p 12345:12345 -p 7655:22 ubuntu:re`  
`docker cp ./maliciousfile reverseme:/tmp`  
`docker exec -ti reverseme /bin/bash -c 'cd /tmp && /bin/bash'`
