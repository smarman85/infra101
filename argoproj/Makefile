DATE := $(shell date +%FT%T%Z)
# argocd admin password set to: admin
# below is the escaped version of the password coming from: htpasswd -bnBC 10 "" admin | tr -d ':\n' | sed 's/$2y/$2a/'
ADMIN_PASSWORD := $$2a$$10$$fHMjO5gJhVg1fSU/lUwubO96tr4OiaKp9TdHTAjYm4z8eIfLNJOgK # admin
WEBHOOK_POD := $(shell kubectl -n argo-events get pod -l eventsource-name=webhook -o name)
CLUSTER_NAME := lab

build-cluster:
	kind create cluster --name $(CLUSTER_NAME) --config ./config/kind-cluster.yaml

build-cluster-linux:
	systemd-run --scope --user -p "Delegate=yes" kind create cluster --name $(CLUSTER_NAME) --config ./config/kind-cluster.yaml

delete-cluster:
	kind delete cluster	-n $(CLUSTER_NAME)

create-namespaces:
	kubectl create namespace argo
	kubectl create namespace argocd
	kubectl create namespace argo-events

argocd:
	kubectl apply -f ./charts/infra/argocd/install.yaml -n argocd
	# kubectl patch secret argocd-secret -n argocd -p '{"stringData": {"admin.password": "$(ADMIN_PASSWORD)", "admin.passwordMtime": "$(DATE)"}}'

argocd-patch-secret:
	kubectl patch secret argocd-secret -n argocd -p '{"stringData": {"admin.password": "$(ADMIN_PASSWORD)", "admin.passwordMtime": "$(DATE)"}}'

argocd-ui:
	kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=30s --timeout=60s
	open /Applications/Google\ Chrome.app/ "https://0.0.0.0:30080/applications"

argo-workflows:
	kubectl apply -f ./charts/infra/argo-workflows/install.yaml -n argo
	# bypass ui for login 
	kubectl patch deployment argo-server --namespace argo --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [ "server", "--auth-mode=server" ]}]'

argo-workflows-ui:
	kubectl wait --for=condition=available deployment/argo-server -n argo --timeout=30s --timeout=60s
	open /Applications/Google\ Chrome.app/ "https://0.0.0.0:32746/workflows/undefined?&limit=50"

argo-events:
	kubectl apply -f ./charts/infra/argo-events/install.yaml -n argo-events
	kubectl apply -n argo-events -f ./charts/infra/argo-events/native.yaml
	kubectl apply -n argo-events -f ./charts/infra/argo-events/sensor-rbac.yaml
	kubectl apply -n argo-events -f ./charts/infra/argo-events/workflow-rbac.yaml

demo-workflow:
	kubectl apply -n argo -f ./demo/workflow/install.yaml

demo-dag:
	kubectl apply -n argo -f ./demo/dag/install.yaml

demo-cron:
	kubectl apply -n argo -f ./demo/cron/install.yaml

demo-webhook:
	kubectl apply -f ./demo/argoCDApps/webhook.yaml
	kubectl -n argo-events port-forward $(WEBHOOK_POD) 12000:12000 &

demo-webhook-run:
	curl -d '{"peanut-butter":"jelly time"}' -H "Content-Type: application/json" -X POST http://localhost:12000/example

init-argo: argocd argocd-patch-secret argo-workflows argo-events 
init: build-cluster create-namespaces argocd argocd-patch-secret argo-workflows argo-events 
init-linux: build-cluster-linux create-namespaces argocd argocd-patch-secret argo-workflows argo-events 
