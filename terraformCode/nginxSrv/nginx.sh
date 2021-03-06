#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo mkdir /data
sudo mkdir /data/images
sudo aws s3 sync s3://kolorabi/ /data/images
cd /etc/nginx/sites-available
sudo rm /etc/nginx/sites-enabled/default
sudo touch app-image
echo "server {
        listen 80;
        server_name http://first_alb;
        return 301 http://second_alb:8080;
}" >> app-image
#sudo systemctl enable nginx
