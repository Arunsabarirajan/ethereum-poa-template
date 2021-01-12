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

ENTRYPOINT ["/bin/bash"]

