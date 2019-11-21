#!/bin/bash
ACME_DIR="/etc/nginx/ssl/"
python acme_tiny.py --account-key ./account.key --csr ./domain.csr --acme-dir $ACME_DIR > ./signed.crt
cat signed.crt intermediate.pem > chained.pem
# 重启
systemctl restart nginx
systemctl restart dovecot
systemctl restart postfix