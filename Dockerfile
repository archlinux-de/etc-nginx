FROM alpine

RUN apk --no-cache add nginx nginx-mod-http-brotli openssl py-pip && pip install gixy
RUN mkdir -p /etc/ssl/private && openssl dhparam -out /etc/ssl/private/dhparams.pem 1024

RUN for d in archlinux.de pierre-schmitz.com laber-land.de; do \
    mkdir -p /etc/letsencrypt/live/$d; \
    openssl req -new -newkey rsa:1024 -days 7 -nodes -x509 \
        -subj "/CN=$d" \
        -keyout /etc/letsencrypt/live/$d/privkey.pem -out /etc/letsencrypt/live/$d/fullchain.pem; \
    done
