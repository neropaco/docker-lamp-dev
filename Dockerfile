FROM stonedz/docker-lamp:latest
MAINTAINER Paolo Fagni <paolo.fagni@gmail.com>

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
        apt-get update && \
        apt-get -y dist-upgrade


# we use the enviroment variable to stop debconf from asking questions..
#RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y php5-xdebug

# package install is finished, clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# install custom config files
ADD xdebug.ini /etc/php5/mods-available/xdebug.ini
ADD nginx.conf /etc/nginx/nginx.conf
ADD php.ini /etc/php5/fpm/php.ini

# clean up tmp files (we don't need them for the image)
RUN rm -rf /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
