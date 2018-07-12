
FROM docker.elastic.co/logstash/logstash-oss:6.2.3

COPY --chown=logstash:logstash docker /
