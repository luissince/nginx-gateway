FROM nginx

RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY conf/* /etc/nginx/

RUN mkdir api_conf.d

COPY conf/api_conf.d/api_servicios.conf /etc/nginx/api_conf.d/api_servicios.conf

#EXPOSE 80

#COPY certs/bookstore.io.crt /etc/ssl/certs/bookstore.io.crt
#COPY certs/bookstore.io.key /etc/ssl/certs/bookstore.io.key

RUN apt-get update

RUN apt-get install nano -y

RUN apt-get install python3 -y

RUN apt-get install python3-dev -y

#RUN apt-get install py3-pip -y

#RUN apt-get install build-base -y

#RUN apt-get install libressl-dev -y 

RUN apt-get install musl-dev -y

RUN apt-get install libffi-dev -y

RUN apt-get install python3-pip -y

RUN pip3 install pip --upgrade

RUN pip3 install certbot-nginx

RUN mkdir /etc/letsencrypt

EXPOSE 80

COPY certbot.sh /.

RUN chmod +x certbot.sh

CMD /certbot.sh
