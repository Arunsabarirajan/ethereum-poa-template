FROM ethereum/client-go:alltools-stable

# alpine sdk - curl, gcc, make, g++, git
EXPOSE 30303 30303/udp 8545 8546

RUN apk add --update \
  alpine-sdk \
  bash \
  vim \
  python3 \
  net-tools \
  nodejs \
  nodejs-npm \
  curl \
  lsof

USER root

RUN mkdir -p /home/eth-node
WORKDIR /home/eth-node

ADD runGeth.sh /home/eth-node/runGeth.sh

ENTRYPOINT ["bash"]