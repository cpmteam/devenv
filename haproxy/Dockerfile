FROM dockercloud/haproxy

MAINTAINER Dmitry Maslennikov <mrdaimor@gmail.com>

WORKDIR /certs/

RUN apk update && apk add openssl \
 && mkdir -p /tmp/certs/ \
 && cd /tmp/ \
 && openssl req -x509 -sha256 -newkey rsa:2048 -keyout xip.key -out xip.crt -days 120 -nodes -subj '/CN=*.xip.io' \
 && cat xip.key xip.crt > /certs/xip.io.pem \
 && rm -rf /tmp/certs  

ENV DEFAULT_SSL_CERT="$(awk 1 ORS='\\n' ~/cert.pem)"
