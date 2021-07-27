#!/bin/bash

echo "Removing existing secret oidcmap-secret"

kubectl -n gridmap delete secret oidcmap-secret

echo "Creating secret oidcmap-secret"

kubectl -n gridmap create secret generic oidcmap-secret --from-file=/var/www/html/index.html #--dry-run=client -o yaml | kubectl apply --validate=false  -f  -
