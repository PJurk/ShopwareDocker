docker-compose up -d --build
docker exec -it my-shopware composer install
docker exec -it my-shopware ./psh.phar install
docker exec -it my-shopware chown -R www-data:www-data .
docker exec -it my-shopware chmod -R 777 .
docker exec -it my-shopware chmod -R 660 config/jwt/public.pem
docker exec -it my-shopware chmod -R 660 config/jwt/private.pem
./copyfromcontainer.sh