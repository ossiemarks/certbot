#!/bin/bash -e

#Run Certbot and send success/failure to slack
#URL determines channel
URL=https://hooks.slack.com/services/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
NAME="Certbot_zeetta_cloud"
CERTS="/etc/letsencrypt/live/zeetta.cloud/fullchain.pem"
if [ -e $CERTS ] 
then
MESSAGE="Certbot worked"
else
MESSAGE="Certbot failed"
fi
curl -X POST --data-urlencode "payload={\"username\":\"$NAME\", \"text\":\"$MESSAGE\"}" $URL