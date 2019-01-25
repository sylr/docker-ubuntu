FROM ubuntu:16.04

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y \
	man \
	curl \
	wget \
	tcpdump \
	jq \
	ipcalc \
	git \
	build-essential \
	vim \
	dnsutils \
	bash-completion \
	mtr \
	iputils-ping \
	prometheus-node-exporter

CMD ["/bin/bash", "-c", "while [ true ]; do sleep 5; done"]
