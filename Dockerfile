FROM debian

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget nginx-full
RUN mkdir /usr/share/nginx/www/kibana/
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN (cd /tmp && wget --no-check-certificate https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && cd kibana-* && cp -rf ./* /usr/share/nginx/www/)
RUN rm -rf /tmp/*
EXPOSE 80

ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

CMD ["/usr/local/bin/run"]
