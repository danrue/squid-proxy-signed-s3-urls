FROM minimum2scp/squid:latest

COPY squid.local.conf /etc/squid/
COPY storeid_db /etc/squid/

