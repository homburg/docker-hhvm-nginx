FROM ubuntu:13.10

MAINTAINER Thomas B Homburg <thomas@homburg.dk>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -qy install wget sudo

RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu saucy main > /etc/apt/sources.list.d/hhvm.list
RUN apt-get update
RUN apt-get -qy install hhvm nginx

# ADD nginx site
RUN rm -f /etc/nginx/sites-enabled/default
ADD site /etc/nginx/sites-enabled/site

# Add run script for starting nginx and hhvm server
ADD run.sh /root/run.sh

# Create dir for web root
# Mount this as a volume, to use local folder
# eg.
#   # Mount local folder and expose on host port 8080
#   $ docker run -v $HOME/code/hhvm:/srv/www -p 8080:80 -d hhvm-nginx
#
RUN mkdir -p /srv/www
RUN chown -R www-data:www-data /srv/www

# Setup hhvm for fastcgi
RUN /usr/share/hhvm/install_fastcgi.sh

# Use hhvm for /usr/bin/php
RUN /usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60

# Create writeable dir for www-data
RUN mkdir -p /home/www-data
RUN chown -R www-data:www-data /home/www-data
# Default command
CMD /root/run.sh www-data /home/www-data /srv/www
