FROM nginx:alpine

# Eliminar los archivos de configuración predeterminados de Nginx
RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copiar los archivos de configuración personalizados
COPY conf/*.conf /etc/nginx/
COPY conf/services/api_servicios.conf /etc/nginx/conf.d/

# Eliminar el contenido predeterminado de /usr/share/nginx/html
RUN rm -rf /usr/share/nginx/html/*

# Copiar los archivos HTML personalizados
COPY conf/templates/* /usr/share/nginx/html/

# Instalar las dependencias de Python y otras herramientas
RUN apk --no-cache add \
    python3 \
    python3-dev \
    py3-pip \
    alpine-sdk \
    certbot \
    && rm -rf /var/cache/apk/*

# Crear el directorio de certificados si no existe
RUN mkdir -p /etc/letsencrypt

# Exponer los puertos 80 y 443
EXPOSE 80
EXPOSE 443

# Copiar el script de certbot
COPY certbot.sh /

# Dar permisos de ejecución al script de certbot
RUN chmod +x /certbot.sh

# Ejecutar el script de certbot al iniciar el contenedor
CMD /certbot.sh
