
$p = (pwd) -replace "([A-Z]{1}):\\","/`$1/"
$env:PWD = ($p.substring(0,2).ToLower() + $p.substring(2)).replace("\", "/")
Get-ChildItem Env:PWD

$env:IMAGE_ARG_LOGSTASH_IMAGE_NAME = 'logstash'

docker-compose down -v
docker-compose up -d
docker-compose logs -f
