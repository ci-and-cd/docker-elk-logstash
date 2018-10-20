
ARG IMAGE_ARG_LOGSTASH_IMAGE_NAME
ARG IMAGE_ARG_LOGSTASH_IMAGE_VERSION

FROM docker.elastic.co/logstash/${IMAGE_ARG_LOGSTASH_IMAGE_NAME:-logstash}:${IMAGE_ARG_LOGSTASH_IMAGE_VERSION:-5.6.10} as base

FROM scratch

COPY --from=base / /

COPY --chown=logstash:logstash docker /

ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/logstash/bin:$PATH
# Ensure Logstash gets a UTF-8 locale by default.
ENV LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8'

WORKDIR /usr/share/logstash

RUN chown logstash:logstash /usr/share/logstash/ \
    && mkdir -p /usr/share/logstash/log \
    && chown --recursive logstash:logstash config/ data/ log/ pipeline/

USER logstash

EXPOSE 9600 5044

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
