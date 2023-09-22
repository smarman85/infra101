FROM alpine:3.18.3

RUN apk update && apk add neofetch

RUN wget https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz && \
    tar -zxvf helm-v3.5.4-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm 

WORKDIR /app/helm

CMD ["/bin/bash"]
