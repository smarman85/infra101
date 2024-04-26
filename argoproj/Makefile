build-cluster:
	kind create cluster --config ./config/kind-cluster.yaml

delete-cluster:
	kind delete cluster	-n argoproj

create-namespaces:
	kubectl create namespace argo
	kubectl create namespace argocd
	kubectl create namespace argo-events

argocd:
	kubectl apply -f ./charts/infra/argocd/install.yaml -n argocd

argo-workflows:
	kubectl apply -f ./charts/infra/argo-workflows/install.yaml -n argo

argoworkflows:

init: build-cluster create-namespaces argocd