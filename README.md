# docker-octoprint

This image based on [the origin's repo](https://github.com/OctoPrint/octoprint-docker), but was made simplify and clearly.
`mjpg-streamer` is supposed to be used as separate container.

## Quick start

```bash
docker volume create octoprint
docker run -d --restart unless-stopped -p 80:80 --device /dev/ttyACM0 -v octoprint:/octoprint --name octoprint urpylka/octoprint:latest
```

It has prebuild images for:

* `linux/amd64`
* `linux/arm/v6`
* `linux/arm/v7`
* `linux/arm64`

If you wanna build own images, use:

```bash
docker build . --tag urpylka/octoprint:latest
```

or with `dockerx`:

```bash
docker buildx create --use
docker buildx build \
    --tag urpylka/octoprint:latest \
    --platform linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64
```
