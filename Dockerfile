FROM archlinux

RUN pacman -Syu --noconfirm --cachedir /tmp/pacman-cache nginx nginx-mod-brotli nginx-mod-headers-more python-pip
RUN pip install --break-system-packages gixy-ng
RUN mkdir -p /etc/ssl/private && openssl dhparam -out /etc/ssl/private/dhparams.pem 2048

RUN for d in archlinux.de laber-land.de; do \
    mkdir -p /etc/letsencrypt/live/$d; \
    openssl req -new -newkey rsa:2048 -days 7 -nodes -x509 \
    -subj "/CN=$d" \
    -keyout /etc/letsencrypt/live/$d/privkey.pem -out /etc/letsencrypt/live/$d/fullchain.pem; \
    done
