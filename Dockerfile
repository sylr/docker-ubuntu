FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y \
	curl \
	man \
	wget \
	tcpdump \
	jq \
	ipcalc \
	git \
	vim \
	dnsutils \
	bash-completion \
	mtr \
	iputils-ping \
	unzip \
	&& \
	rm -rf /var/cache/apt

RUN curl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
	chmod +x /usr/local/bin/kubectl

RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

RUN cd /tmp && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf *

WORKDIR /root

RUN cat /etc/skel/.bashrc > /root/.bashrc
RUN echo "complete -C '/usr/local/bin/aws_completer' aws\nsource <(kubectl completion bash)\nsource <(helm completion bash)" >> /root/.bashrc

CMD ["/bin/bash", "-c", "while [ true ]; do sleep 5; done"]
