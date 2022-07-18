rm -rf source && mkdir source
tar -xzvf source.tar.gz -C ./source
cp .env source && cd source

docker stop $(docker ps -a | grep hidevs_ | awk '{print $1}')
docker rm $(docker ps -a | grep hidevs_ | awk '{print $1}')
docker volume rm $(docker volume ls --filter name=hidevs_ -q)

tar -xzvf app.tar.gz -C /
docker-compose up --build --force-recreate -d

cd .. && rm -rf $(pwd)
