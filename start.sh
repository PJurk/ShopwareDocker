git clone https://github.com/shopware/development.git
docker-compose up -d --build
docker exec -it my-shopware composer install
cp Docker/Shopware/.env.dist development/.env.dist
cp Docker/Shopware/.psh.yml.dist development/.psh.yml.dist
cp Docker/Shopware/.psh.yml.override development/.psh.yml.override
chmod -R 777 development/
docker exec -it my-shopware ./psh.phar install
docker exec -it my-shopware chown -R www-data:www-data .
docker exec -it my-shopware chmod -R 777 .
docker exec -it my-shopware chmod -R 660 config/jwt/public.pem
docker exec -it my-shopware chmod -R 660 config/jwt/private.pem