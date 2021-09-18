FROM node:14.17.5-buster AS node
FROM ruby:3.0.2-buster

# update
RUN apt-get update -y
RUN apt-get upgrade -y

# nginx
COPY ./docker/scripts/nginx-on-debian/install-nginx.sh /root/install-nginx.sh
RUN bash /root/install-nginx.sh
RUN rm -f /root/install-nginx.sh

# node
COPY --from=node /usr/local/bin/node /usr/local/bin/

# yarn
COPY --from=node /opt/yarn-v1.22.5 /opt/yarn-v1.22.5/
RUN ln -s /opt/yarn-v1.22.5/bin/yarn /usr/local/bin/yarn && \
    ln -s /opt/yarn-v1.22.5/bin/yarnpkg /usr/local/bin/yarnpkg

# jemalloc
RUN apt-get update && apt-get upgrade -y && apt-get install -y libjemalloc-dev libjemalloc2
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
