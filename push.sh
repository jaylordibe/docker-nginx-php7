#!/usr/bin/env bash

# Push to docker repository
docker tag docker-nginx-php7_nginx-php7:latest jaylordibe/nginx-php7:latest
docker push jaylordibe/nginx-php7:latest

# Push to github repository
git add .
git commit -m "Updated docker image"
git push origin main
