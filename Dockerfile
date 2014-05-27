FROM base
MAINTAINER Arcus "http://arcus.io"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget nginx-full
RUN mkdir /usr/share/nginx/www/kibana/
RUN (cd /tmp && wget --no-check-certificate https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && cd kibana-* && cp -rf ./* /usr/share/nginx/www/kibana/)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

## listen on 8080, not 80
RUN sed -i  -E 's|#listen.*80;.*|listen 8080;|' /etc/nginx/sites-enabled/default
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN rm -rf /tmp/*

EXPOSE 8080
CMD ["/usr/local/bin/run"]
