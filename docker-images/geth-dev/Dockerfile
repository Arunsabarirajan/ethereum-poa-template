FROM ethereum/client-go:alltools-stable

# alpine sdk - curl, gcc, make, g++, git
RUN apk add --update \
  alpine-sdk \
  bash \
  vim \
  python3 \
  net-tools \
  nodejs \
  nodejs-npm \
  lsof

RUN npm install -g pm2

ENTRYPOINT ["/bin/bash"]
