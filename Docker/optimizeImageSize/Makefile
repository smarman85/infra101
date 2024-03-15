build-base:
	podman build -t base -f Dockerfile.base . && \
	podman run -dith base --name base -p 127.0.0.1:9990:8080 \
	--name base localhost/base:latest

build-multi:
	podman build -t multi -f Dockerfile.multi . && \
	podman run -dith multi --name multi -p 127.0.0.1:9992:8080 \
	--name multi localhost/multi:latest

build-multi-busybox:
	podman build -t multi-busybox -f Dockerfile.multi-busybox . && \
	podman run -dith multi-busybox --name multi-busybox -p 127.0.0.1:9994:8080 \
	--name multi-busybox localhost/multi-busybox:latest

build-multi-scratch:
	podman build -t multi-scratch -f Dockerfile.multi-scratch . && \
	podman run -dith multi-scratch --name multi-scratch -p 127.0.0.1:9996:8080 \
	--name multi-scratch localhost/multi-scratch:latest

build-multi-scratch-a:
	podman build -t multi-scratch-a -f Dockerfile.multi-scratch-a . && \
	podman run -dith multi-scratch-a --name multi-scratch-a -p 127.0.0.1:9998:8080 \
	--name multi-scratch-a localhost/multi-scratch-a:latest

build-all: build-base build-multi build-multi-busybox build-multi-scratch build-multi-scratch-a

clean-containers: 
	podman rm -f base multi multi-busybox multi-scratch multi-scratch-a

clean-images: 
	podman rmi -f base multi multi-busybox multi-scratch multi-scratch-a

clean-all: clean-containers clean-images