
ARG IMAGE_ARG_LOGSTASH_IMAGE_NAME
ARG IMAGE_ARG_LOGSTASH_IMAGE_VERSION

FROM docker.elastic.co/logstash/${IMAGE_ARG_LOGSTASH_IMAGE_NAME:-logstash}:${IMAGE_ARG_LOGSTASH_IMAGE_VERSION:-7.4.2} as base

FROM scratch

COPY --from=base / /

COPY --chown=logstash:logstash docker /

ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/logstash/bin:$PATH
# Ensure Logstash gets a UTF-8 locale by default.
ENV LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8'

WORKDIR /usr/share/logstash

RUN set -ex \
  && chown logstash:logstash /usr/share/logstash/ \
  && mkdir -p /usr/share/logstash/log \
  && chown --recursive logstash:logstash config/ data/ log/ pipeline/

# Unable to remove plugin because of error: "You are using the standard distribution of logstash.
# Please install the OSS-only distribution to remove X-Pack features."
# Remove X-Pack.
#RUN set -ex \
#  && /usr/share/logstash/bin/logstash-plugin remove x-pack

# Install logstash-filter-multiline
RUN set -ex \
  && bin/logstash-plugin install logstash-filter-multiline \
  && bin/logstash-plugin list \
  && cat config/logstash.yml \
  && bin/logstash --config.test_and_exit -f pipeline/logstash.conf

RUN set -ex \
  && curl -sSL -o /usr/share/logstash/logstash-filter-simple_kv-1.0.1.gem https://rubygems.org/downloads/logstash-filter-simple_kv-1.0.1.gem \
  && bin/logstash-plugin install --no-verify --local logstash-filter-simple_kv-1.0.1.gem \
  && curl -sSL -o /usr/share/logstash/logstash-filter-time_chunks-1.0.2.gem https://rubygems.org/downloads/logstash-filter-time_chunks-1.0.2.gem \
  && bin/logstash-plugin install --no-verify --local logstash-filter-time_chunks-1.0.2.gem
#  && bin/logstash-plugin install --no-verify --version 1.0.2 logstash-filter-time_chunks

USER logstash

EXPOSE 9600 5044

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
