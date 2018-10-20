
ARG IMAGE_ARG_LOGSTASH_IMAGE_NAME
ARG IMAGE_ARG_LOGSTASH_IMAGE_VERSION

FROM docker.elastic.co/logstash/${IMAGE_ARG_LOGSTASH_IMAGE_NAME:-logstash}:${IMAGE_ARG_LOGSTASH_IMAGE_VERSION:-5.6.10} as base

FROM scratch

COPY --from=base / /

COPY --chown=logstash:logstash docker /
