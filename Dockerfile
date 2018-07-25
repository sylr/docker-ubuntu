FROM ubuntu:16.04

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y curl tcpdump jq ipcalc git build-essential

CMD ["/bin/bash", "-c", "while [ true ]; do sleep 5; done"]
