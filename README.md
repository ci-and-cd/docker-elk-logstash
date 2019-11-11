# docker-logstash

Logstash (part of ELK stack)

[Official](https://www.elastic.co/guide/en/logstash/current/docker.html)
[Official Dockerfile on Github](https://github.com/elastic/logstash/blob/master/docker/templates/Dockerfile.j2)
[Official Github](https://github.com/elastic/logstash)
[Deprecated repo on Docker Hub](https://hub.docker.com/_/logstash/)


### Test config file

`docker run -e PIPELINE_WORKERS=3 --rm -it cirepo/logstash:${IMAGE_TAG:-7.4.2} bin/logstash --config.test_and_exit -f pipeline/logstash.conf`


### Find out why it is slow

http://localhost:9600/_node/stats/pipelines?pretty
http://localhost:9600/_node/stats/pipelines/main?pretty
