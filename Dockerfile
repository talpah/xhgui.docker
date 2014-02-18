FROM debian:wheezy

MAINTAINER Cosmin Iancu <phprecode@gmail.com>

RUN apt-get update
RUN apt-get -y install wget
RUN echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
RUN wget http://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5 php5-curl git php5-mongo mongodb php5-mcrypt php5-xhprof

RUN git clone https://github.com/perftools/xhgui.git /var/www/xhgui
RUN chmod -R 0777 /var/www/xhgui/cache
RUN echo "date.timezone = UTC" >> /etc/php5/cli/php.ini

RUN cd /var/www/xhgui/ && php install.php

EXPOSE 80 27017

ADD start.sh /root/start.sh

ENTRYPOINT ["/root/start.sh"]
CMD ["--"]

