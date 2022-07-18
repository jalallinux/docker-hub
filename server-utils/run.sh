docker stop $(docker-compose ps | grep hidevs_ | awk '{print $1}')
docker rm $(docker-compose ps | grep hidevs_ | awk '{print $1}')
#docker volume rm $(docker volume ls --filter name=hidevs_ -q)

tar -xzvf app.tar.gz -C /
docker-compose up --build --force-recreate -d
rm -rf /docker
