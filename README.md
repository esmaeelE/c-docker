# C dockerize

C program inside docker container

This repository demonstrates a minimal "Hello World" program written in C, containerized using Docker. The image is built using multi-stage builds to achieve a very small final image size (~8.5 MB).
This repository demonstrates a minimal "Hello World" program written in C, containerized using Docker.  
Thanks to multi-stage builds, static compilation, and the `scratch` base image, the final image is extremely small (~8.5 MB).

## Files

- `main.c`: The source code for the simple "Hello World" program.
- `Dockerfile`: Multi-stage build instructions.
- `Makefile`: Automation for common tasks (build, run, clean, check size).

## Build

```bash
docker build -t docker-hello-world-c .
```

## Run

```bash
docker run docker-hello-world-c
```

## Image Size

```bash
$ docker image ls
docker-hello-world-c   latest    a2de7929897b   4 seconds ago   8.46MB
```

### Build the image

```bash

make build
```

### Build and run the container (most common)

```bash

make run
```

### Build and export to host

```bash

make extract
```

### View the image size

```bash
make size
```

### Clean up the image

```bash
make clean
```
