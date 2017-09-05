FROM debian:jessie

RUN apt-get update && apt-get install -y squid3 vim less
COPY squid.lab.conf /etc/squid3/squid.conf
COPY storeid_file_rewrite /opt/scripts/squid/
RUN chmod a+x /opt/scripts/squid/storeid_file_rewrite
COPY storeid_db /opt/scripts/squid/
RUN mkdir -p /cache/squid3 && chown proxy /cache/squid3
RUN rm -f /etc/squid/squid.local.conf

