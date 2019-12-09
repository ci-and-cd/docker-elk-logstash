
#export LS_COMMAND="logstash --verbose --debug"
export LS_HEAP_SIZE="5g"
export MEM_LIMIT="6g"

docker-compose down -v

read -p "Do you want clear data: " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find data/logstash/data ! -name '.gitignore' ! -name 'logstash.json' ! -name 'logstash-*.json' ! -name 'syslog-*.log' ! -name '*.sh' -type f -exec rm -rf {} +
fi

docker-compose up -d
docker-compose logs -f
