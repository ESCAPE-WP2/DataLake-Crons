#!/bin/bash

echo "Removing existing secret xcache-authfile-secret"

kubectl -n gridmap delete secret xcache-authfile-secret

echo "Creating secret xcache-authfile-secret"

kubectl -n gridmap create secret generic xcache-authfile-secret --from-file=/var/www/html/index.html #--dry-run=client -o yaml | kubectl apply --validate=false  -f  -
