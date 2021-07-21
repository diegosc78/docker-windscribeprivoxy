# VPN Proxy

## What's this?

This is a docker image source (Dockerfiles) for an HTTP (privoxy) at port 8118. It uses as backend network a VPN network (windscribe free account)

## References

- <https://github.com/wiorca/docker-windscribe> My starting point
- <https://github.com/dockage/tor-privoxy> From here I took the idea of combining privoxy and vpn client
- <https://opensourcelibs.com/lib/gluetun> This was my original attempt, but didn't worked for me (maybe because i haven't a "pro" account in windscribe)

## Variants

- Dockerfile : tested on my amd64 laptop
- Dockerfile.arm64 : tested on raspberry 4 and rock64.

## Run

```bash
docker run -it --rm --name windscribe-privoxy --cap-add NET_ADMIN --dns 1.1.1.1 -e WINDSCRIBE_USERNAME=cponte124 -e WINDSCRIBE_PASSWORD=XXXXXXXXX -p 8118:8118 ponte124/windscribeprivoxy:v2107-arm64v8
```

Use other tag for amd64

## Use it

Just configure your app to use http proxy against container port 8118


## Kubernetes

I have a simple helm char for this. I'll publish when I have it better tested.


## To do

- Use alpine instead of debian
- windscribe arm64 binaries instead of armhf binaries (nowadays windscribe only has a deb package for armhf)

