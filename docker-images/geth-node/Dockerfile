FROM arunsabarirajan/geth-base:latest

USER root

RUN mkdir -p /home/eth-node
WORKDIR /home/eth-node

ADD runGeth.sh /home/eth-node/runGeth.sh

SHELL ["/bin/bash", "-c"]

ENTRYPOINT ["/home/eth-node/runGeth.sh"]