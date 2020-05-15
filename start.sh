docker-compose up -d --build
docker exec -it my_shopware composer install
docker exec -it my_shopware ./psh.phar install
./copyfromcontainer.sh