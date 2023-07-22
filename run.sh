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
# - Se ejecuta en segundo plano (modo detached) con la opción "-d".
# - Se reinicia automáticamente en caso de fallos con la opción "--restart always".
# - Se le asigna el nombre "api-gateway" con la opción "--name api-gateway".
# - Se conecta a la red "upla" con la opción "--net=upla".
# - Los puertos 80 y 443 del contenedor se mapean a los puertos 80 y 443 del host con las opciones "-p 80:80" y "-p 443:443".
# - Se monta un volumen en la ruta "$(pwd)/certs" del host en el directorio "/etc/letsencrypt" del contenedor, lo que permite utilizar certificados SSL/TLS con la opción "-v $(pwd)/certs:/etc/letsencrypt".
# - Finalmente, se utiliza la imagen "api-gateway" recién construida para iniciar el contenedor.
docker run -d \
--restart always \
--name nginx-gateway \
--net=luis \
-p 80:80 \
-p 443:443 \
-v $(pwd)/certs:/etc/letsencrypt \
nginx-gateway-image