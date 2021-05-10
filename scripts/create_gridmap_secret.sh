#!/bin/bash

echo "Removing existing secret gridmap-secret"

kubectl -n gridmap delete secret gridmap-secret

echo "Creating secret gridmap-secret"

kubectl -n gridmap create secret generic gridmap-secret --from-file=/var/www/html/index.html #--dry-run=client -o yaml | kubectl apply --validate=false  -f  -
