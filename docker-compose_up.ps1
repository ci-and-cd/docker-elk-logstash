
$p = (pwd) -replace "([A-Z]{1}):\\","/`$1/"
$env:PWD = ($p.substring(0,2).ToLower() + $p.substring(2)).replace("\", "/")
Get-ChildItem Env:PWD

$env:IMAGE_ARG_LOGSTASH_IMAGE_NAME = 'logstash'
$env:LOGSTASH_ENVIRONMENT = 'dev'
#$env:OUTPUT_ELASTICSEARCH_HOSTS = '172.16.238.62:9200'
$env:OUTPUT_ELASTICSEARCH_HOSTS = '10.3.5.12:9200'

docker-compose down -v

$confirmation = Read-Host "Do you want clear data"
if ($confirmation -eq "y") {
    Remove-Item -Path "data\logstash\data\*" -Exclude ".gitignore", "logstash.json", "logstash-*.json", "*syslog-*.log", "*.sh" -Recurse;
}

docker-compose up -d
docker-compose logs -f
