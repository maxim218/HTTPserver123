FROM ubuntu:16.04

MAINTAINER Maxim_Kolotovkin_User

USER root

RUN apt-get -y update
RUN apt-get install -y ruby-full

ENV APP /root/app
ADD ./ $APP
WORKDIR $APP

EXPOSE 5005

CMD ruby main.rb

