rm -rf ./development
mkdir /c/development
docker cp my_shopware:/var/www/html/. /c/development
mv /c/development $(pwd)