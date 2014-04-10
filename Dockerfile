FROM debian:wheezy

MAINTAINER Thomas B Homburg <thomas@homburg.dk>

RUN curl http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu saucy main > /etc/apt/sources.list.d/hhvm.list
RUN sudo apt-get update
RUN sudo apt-get -qy install hhvm

