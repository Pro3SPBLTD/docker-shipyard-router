FROM ubuntu:12.04
MAINTAINER Shipyard Project "http://shipyard-project.com"
RUN apt-get -qq update
RUN apt-get install -y g++ make python-dev python-setuptools libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make wget git-core
RUN wget http://nodejs.org/dist/v0.8.26/node-v0.8.26.tar.gz -O /tmp/node.tar.gz
RUN (cd /tmp && tar zxf node.tar.gz)
RUN (cd /tmp/node-* && ./configure)
RUN (cd /tmp/node-* && make install)
RUN npm install git+http://github.com/shipyard/hipache.git -g
ADD run.sh /usr/local/bin/run
VOLUME /var/log/shipyard
EXPOSE 80
EXPOSE 443
CMD ["/bin/sh", "-e", "/usr/local/bin/run"]
