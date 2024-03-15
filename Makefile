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


layer-start-build:
	podman build -t start --build-arg password='D@ntUs3!!' ./Docker/layers/start/

layer-start-run:
	podman run -dith start -p 8080:8080 --name start start /go/bin/app

layer-start-attach:
	podman exec -it start bash

layer-start: layer-start-build layer-start-run

layer-start-destroy:
	podman rm -f start


layer-badfix-build:
	podman build -t badfix ./Docker/layers/badfix/

layer-badfix-run:
	podman run -dith badfix -p 8090:8090 --name badfix badfix /go/bin/app

layer-badfix-attach:
	podman exec -it badfix bash

layer-badfix: layer-badfix-build layer-badfix-run

layer-badfix-destroy:
	podman rm -f badfix


layer-fix-build:
	podman build -t fix ./Docker/layers/fix/

layer-fix-run:
	podman run -dith fix -p 8100:8100 --name fix fix /app

layer-fix-debug:
	podman run -dith fix -p 8100:8100 --name fix fix

layer-fix-attach:
	podman exec -it fix sh

layer-fix: layer-fix-build layer-fix-run

layer-fix-destroy:
	podman rm -f fix


clean-all:
	podman rm -f start badfix fix
	podman rmi -f start badfix fix