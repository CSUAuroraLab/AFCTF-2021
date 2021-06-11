FROM tutum/lamp:latest

ENV FLAG flagxxx
RUN rm -rf /var/www/html/*
RUN rm -rf /var/www/html/.git
RUN echo $FLAG > /flag
RUN unset FLAG
COPY index.php config.php /var/www/html/

EXPOSE 80