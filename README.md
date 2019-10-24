# docker-logstash

Logstash (part of ELK stack)

[Official](https://www.elastic.co/guide/en/logstash/current/docker.html)
[Official Dockerfile on Github](https://github.com/elastic/logstash/blob/master/docker/templates/Dockerfile.j2)
[Official Github](https://github.com/elastic/logstash)
[Deprecated repo on Docker Hub](https://hub.docker.com/_/logstash/)

5.6.8-1 upgrade to 6.x

docker pull logstash:5.6.8-alpine
docker pull docker.elastic.co/logstash/logstash:5.6.8
docker pull docker.elastic.co/logstash/logstash:6.2.3
docker pull docker.elastic.co/logstash/logstash-oss:6.2.3

### Test config file

`docker run -e PIPELINE_WORKERS=3 --rm -it cirepo/logstash:${IMAGE_TAG:-7.4.0} bin/logstash --config.test_and_exit -f pipeline/logstash.conf`

