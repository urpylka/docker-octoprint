#! /bin/bash

docker buildx build --push \
    --tag urpylka/octoprint:dev \
    --platform linux/arm/v6 .



docker run -d --restart unless-stopped -p 8080:80 --device /dev/video0 --name mjpg_streamer urpylka/mjpg_streamer:latest /usr/local/bin/mjpg_streamer -i 'input_uvc.so -d /dev/video0 -r 640x480 -f 30 -y -n' -o 'output_http.so -w /usr/local/share/mjpg-streamer/www -p 80'