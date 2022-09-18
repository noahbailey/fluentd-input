FROM ruby:3.1-bullseye

# => Install GeoIP packages
RUN apt-get update && \
    apt-get install -y \
    libgeoip-dev \
    geoip-database \
    geoip-bin

# => Install fluentd + plugins
RUN gem install fluentd                         -v 1.15.1 && \
    gem install fluent-plugin-secure-forward    -v 0.4.5  && \
    gem install fluent-plugin-geoip             -v 1.3.2  && \
    gem install fluent-plugin-opensearch

RUN mkdir /fluentd 

COPY fluentd.conf /fluentd/fluentd.conf

# => Run stage
ENTRYPOINT exec fluentd -c /fluentd/fluentd.conf
