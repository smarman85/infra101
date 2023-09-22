helm-build-podman:
	podman build -t helm ./helm/

helm-run-podman:
	podman run -dith helm --name helm -v ./helm:/app/helm helm sh

helm-connect-podman:
	podman exec -it helm sh

helm-destroy-podman:
	podman rm -f helm

helm-podman: helm-build-podman helm-run-podman helm-connect-podman

helm-build-docker:
	docker build -t helm ./helm/

helm-run-docker:
	docker run -dith helm --name helm -v ./helm:/app/helm/ helm sh

helm-connect-docker:
	docker exec -it helm sh

helm-destroy-docker:
	docker rm -f helm

helm-docker: helm-build-docker helm-run-docker helm-connect-docker