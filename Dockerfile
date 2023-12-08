FROM nginx

RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY conf/* /etc/nginx/

RUN rm -rf /usr/share/nginx/html/*

COPY conf/templates/* /usr/share/nginx/html/

RUN mkdir api_conf.d

COPY conf/api_conf.d/api_servicios.conf /etc/nginx/api_conf.d/api_servicios.conf

RUN apt-get update

RUN apt-get install nano -y

RUN apt-get install python3 -y

RUN apt-get install python3-dev -y

RUN apt-get install python3-pip -y

RUN apt-get install build-essential -y

RUN apt install python3-certbot-nginx -y

RUN if [ ! -d "/etc/letsencrypt" ]; then mkdir /etc/letsencrypt; fi

EXPOSE 80

EXPOSE 443

COPY certbot.sh /.

RUN chmod +x certbot.sh

CMD /certbot.sh