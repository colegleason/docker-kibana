FROM debian

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget nginx-full
RUN mkdir /usr/share/nginx/www/kibana/
WORKDIR /tmp
RUN wget --no-check-certificate https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz -O pkg.tar.gz 2>/dev/null
RUN tar zxf pkg.tar.gz
RUN (cd kibana-* && cp -rf ./* /usr/share/nginx/www/)
RUN rm -rf /tmp/*

RUN wget --no-check-certificate https://github.com/kelseyhightower/confd/releases/download/v0.3.0/confd_0.3.0_linux_amd64.tar.gz -O confd_0.3.0_linux_amd64.tar.gz 2>/dev/null
RUN tar -zxf confd_0.3.0_linux_amd64.tar.gz
RUN mv confd /usr/local/bin/confd

ADD nginx.conf.tmpl /etc/confd/templates/
ADD nginx.toml /etc/confd/conf.d/
ADD config.js /usr/share/nginx/www/config.js

EXPOSE 80
EXPOSE 8081

CMD service nginx start && confd -verbose -node $ETCD_ENDPOINT
