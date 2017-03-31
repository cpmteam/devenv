#/bin/sh

cp ./cpmteam.github.io/package.json ./node/
docker-compose build 
docker-compose up