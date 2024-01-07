#!/bin/bash

# Comentario: Ruta de la carpeta a verificar
carpeta="./certs"

# Comentario: Verificar si la carpeta existe usando el comando test
if [ ! -d "$carpeta" ]; then
    mkdir -m 755 "$carpeta"
fi

# Comentario: Este bloque de comandos detiene y elimina un contenedor existente llamado "api-gateway", si existe.
docker stop nginx-gateway && docker rm nginx-gateway

# Comentario: A continuación, se elimina la imagen del contenedor "api-gateway" para asegurarse de que se construirá nuevamente desde cero.
docker image rm nginx-gateway-image

# Comentario: Se procede a construir una nueva imagen del contenedor "api-gateway" utilizando el Dockerfile presente en el directorio actual.
docker build -t nginx-gateway-image .

# Comentario: Ahora, se ejecuta el contenedor "api-gateway" con las siguientes configuraciones:
docker run -d \
--restart always \
--name nginx-gateway \
--net=luis \
-p 80:80 \
-p 443:443 \
-v $(pwd)/certs:/etc/letsencrypt \
nginx-gateway-image