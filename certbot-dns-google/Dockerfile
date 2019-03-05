FROM certbot/certbot

COPY . src/certbot-dns-google
COPY slack.sh /usr/bin/slack.sh

RUN pip install --constraint docker_constraints.txt --no-cache-dir --editable src/certbot-dns-google
