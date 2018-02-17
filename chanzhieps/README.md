 docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -p 3306:3306  mysql:5.7.20

docker run -d --name chanzhieps \
-e CHANZHI_DB_HOST=10.10.1.206:3306 \
-e CHANZHI_DB_USER=root \
-e CHANZHI_DB_PASS=root \
-e CHANZHI_DB_NAME=chanzhi \
chanzhieps:6.7.1
