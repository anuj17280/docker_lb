FROM nginx:latest

RUN \
  apt-get update && \
  apt-get install -y vim && \
  apt-get install -y net-tools

ENTRYPOINT ["/bin/start.sh"]
EXPOSE 80
VOLUME /templates
ENV CONSUL_URL consul:8500

ADD start.sh /bin/start.sh
ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx_service_http.ctmpl /templates/nginx_service_http.ctmpl

RUN rm -v /etc/nginx/conf.d/*.conf; rm -v /var/log/nginx/*; exit 0

RUN \ 
  ln -s /proc/1/fd/1 /var/log/nginx/access.log 
  ln -s /proc/1/fd/2 /var/log/nginx/error.log

RUN chmod +x /bin/start.sh

ADD https://github.com/hashicorp/consul-template/releases/download/v0.7.0/consul-template_0.7.0_linux_amd64.tar.gz /usr/bin/
RUN tar -C /usr/local/bin --strip-components 1 -zxf /usr/bin/consul-template_0.7.0_linux_amd64.tar.gz
