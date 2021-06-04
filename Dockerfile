FROM debian:stretch

#######################################################################################

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN sudo groupadd -r shellinabox && sudo useradd -r -g shellinabox shellinabox

RUN sudo apt-get update && DEBIAN_FRONTEND=noninteractive sudo apt-get -y install shellinabox ssh sudo

COPY shellinabox_services /shellinabox_services
RUN sudo chmod 600 /shellinabox_services

EXPOSE 4200

#######################################################################################
COPY docker-entrypoint.sh /
COPY docker-command.sh /
RUN sudo chmod +x /docker-entrypoint.sh /docker-command.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/docker-command.sh"]

