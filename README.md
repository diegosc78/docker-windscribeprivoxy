# VPN Proxy

## Qué es

Proxy HTTP (privoxy) en el 8118, que por debajo enruta todo el tráfico por una VPN windscribe

## Referencias

- <https://github.com/wiorca/docker-windscribe> Mi principal punto de partida
- <https://github.com/dockage/tor-privoxy> De aquí saqué la idea de combinar privoxy con el windscribe, al igual que en este ejemplo se combina privoxy con el tor. La diferencia está en que aquí no tenemos que hacer forward por socks (tor abre puerto socks)
- <https://opensourcelibs.com/lib/gluetun> Este fue mi intento original... aunque no me funcionó. Mi hipótesis es que windscribe "capa" accesos con openvpn para cuentas free

## Arrancar

```bash
docker build -t ponte124/windscribeprivoxy:v2107-arm64v8 .
docker run -it --rm --name windscribe-privoxy --cap-add NET_ADMIN --dns 1.1.1.1 -e WINDSCRIBE_USERNAME=cponte124 -e WINDSCRIBE_PASSWORD=XXXXXXXXX -p 8118:8118 ponte124/windscribeprivoxy:v2107-arm64v8
```

## Futuras mejoras

- Usar alpine en lugar de debian como base.
