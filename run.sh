docker stop api-gateway && docker rm api-gateway

docker image rm api-gateway

docker build -t api-gateway .

docker run -d \
--restart always \
--name api-gateway \
--net=upla \
-p 80:80 \
-p 443:443 \
-v $(pwd)/certs:/etc/letsencrypt \
api-gateway
