FROM tutum/lamp:latest
EXPOSE 80
RUN rm -rf /var/www/html/*
RUN rm -rf /var/www/html/.git
COPY ./html /vat/www/html/
CMD ./run.sh