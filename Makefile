.PHONY: build
build:
	docker build -t metashape .

.PHONY: run
run: build
	docker run -v /tmp/.X11-unix:/tmp/.X11-unix:rw --entrypoint metashape/metashape.sh -it metashape

.PHONY: run-diagnosis
run-diagnosis: build
	docker run -v /tmp/.X11-unix:/tmp/.X11-unix:rw -it metashape
