mkdir source
tar -xzvf source.tar.gz -C ./source
cd source

docker stop $(docker-compose ps | grep hidevs_ | awk '{print $1}')
docker rm $(docker-compose ps | grep hidevs_ | awk '{print $1}')
docker volume rm $(docker volume ls --filter name=hidevs_ -q)

tar -xzvf app.tar.gz -C /
docker-compose up --build --force-recreate -d

cd .. && rm -rf $(pwd)
