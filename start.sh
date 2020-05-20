docker-compose up -d --build
docker exec -it my-shopware composer install
docker exec -it my-shopware ./psh.phar install
./copyfromcontainer.sh