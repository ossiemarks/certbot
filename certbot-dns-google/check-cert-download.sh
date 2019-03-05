#!/bin/bash -e

#Run Certbot and send success/failure to slack
#URL determines channel
URL=https://hooks.slack.com/services/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
NAME="Certbot_zeetta_cloud"
CERTS="/etc/letsencrypt/live/${GCLOUD_DOMAIN_NAME}/fullchain.pem"
GCLOUD_CREDENTIALS_FILE=cred.json
GLCOUD_EMAIL_ADDRESS=osman.marks@zeetta.com
GCLOUD_DOMAIN_NAME=test.zeetta.cloud

    if [ -e $CERTS ] 
    then
    MESSAGE="Certbot worked and created ${CERTS}"
    else
    MESSAGE="Certbot failed"
    fi 

docker run -it --rm -v $(pwd)/$GCLOUD_CREDENTIALS_FILE:/$GCLOUD_CREDENTIALS_FILE \
-v $(pwd)/certs:/etc/letsencrypt/ certbot/dns-google certonly --dns-google-credentials /$GCLOUD_CREDENTIALS_FILE  \
-m $GLCOUD_EMAIL_ADDRESS --agree-tos -d $GCLOUD_DOMAIN_NAME --dns-google  -n\

curl -X POST --data-urlencode "payload={\"username\":\"$NAME\", \"text\":\"$MESSAGE\"}" $URL
