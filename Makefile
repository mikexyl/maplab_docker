.PHONY: build run run-local

XAUTH:=/tmp/.docker.xauth

build:
	docker build --build-arg myuser=${shell whoami} -t maplab .

run: build
	docker run -it --rm \
	   --name maplab \
	   --gpus all \
	   --privileged \
	   --env="DISPLAY=${DISPLAY}" \
	   --env="QT_X11_NO_MITSHM=1" \
	   --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	   --env="XAUTHORITY=$(XAUTH)" \
	   --volume="$(XAUTH):$(XAUTH)" \
	   -v /home/lxy/Workspace/mrslam/maplab_ws:/home/lxy/Workspace/mrslam/maplab_ws \
	   -v /home/lxy/Workspace/mrslam/rovio_ws:/home/lxy/Workspace/mrslam/rovio_ws \
	   -v /home/lxy/Datasets:/home/lxy/Datasets \
	   -v /home/lxy/Workspace/mrslam/maskgraph_ws/:/home/lxy/Workspace/mrslam/maskgraph_ws \
	   --runtime=nvidia \
	   -p2222:22 \
	   maplab

run-local: build
	XAUTH=/tmp/.docker.xauth && \
	      touch ${XAUTH} && \
		xauth nlist ${DISPLAY} | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge - && \
	docker run -it --rm \
	   --privileged \
	   --env="DISPLAY=${DISPLAY}" \
	   --env="QT_X11_NO_MITSHM=1" \
	   --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	   -e XAUTHORITY=${XAUTH} \
	   -v "${XAUTH}:${XAUTH}" \
	   --runtime=nvidia \
	   -e HOME=${HOME} \
	   -v "${HOME}=${HOME}/" \
	   -v /etc/group:/etc/group:ro \
	   -v /etc/passwd:/etc/passwd:ro \
	   --security-opt seccomp=unconfined \
	   -p2222:22
	   -u ${shell id -u ${USER} }:${shell id -g ${USER}} \
	   maplab

attach:
	docker exec -it -u ${shell whoami} maplab /bin/bash
