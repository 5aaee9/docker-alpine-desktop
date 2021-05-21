# docker-alpine-desktop

[![Build Image](https://github.com/Indexyz/docker-alpine-desktop/actions/workflows/build.yaml/badge.svg)](https://github.com/Indexyz/docker-alpine-desktop/actions/workflows/build.yaml) [![Docker File Size](https://shields.io/docker/image-size/indexyz/alpine-desktop/latest)](https://hub.docker.com/r/indexyz/alpine-desktop) [![Docker File Size](https://shields.io/docker/pulls/indexyz/alpine-desktop)](https://hub.docker.com/r/indexyz/alpine-desktop)

🐳 Docker desktop environment, xfce + novnc + alpine

## Quick start

```bash
docker run --name vnc \
    --restart=always -d \
    -p 5900:5900 -p 6901:6901 \
    indexyz/alpine-desktop
```

### Ports

- 5900 - VNC Port
- 6901 - NoVNC Port

### Environment

- VNC_RESOLUTION - vnc resolution, default 1280x1024x24
- VNC_PASSWORD - vnc connection password, will generate random password on startup if not set
- VNC_PORT - vnc listen port
- NOVNC_PORT - novnc listen port

## License
WTFPL
