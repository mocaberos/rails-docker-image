FROM node:14.17.5-bullseye AS node
FROM ruby:3.0.2-bullseye

# update
RUN apt-get update && apt-get upgrade -y

# nginx
WORKDIR = /tmp
COPY ./docker/scripts/nginx-on-debian/install-nginx-without-mruby.sh /tmp/install-nginx-without-mruby.sh
RUN bash /tmp/install-nginx-without-mruby.sh && rm -f /tmp/install-nginx-without-mruby.sh

# node
COPY --from=node /usr/local/bin/node /usr/local/bin/node

# yarn
COPY --from=node /opt/yarn-v1.22.5 /opt/yarn-v1.22.5/
RUN ln -s /opt/yarn-v1.22.5/bin/yarn /usr/local/bin/yarn && \
    ln -s /opt/yarn-v1.22.5/bin/yarnpkg /usr/local/bin/yarnpkg

# jemalloc
RUN apt-get install -y libjemalloc-dev libjemalloc2
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
