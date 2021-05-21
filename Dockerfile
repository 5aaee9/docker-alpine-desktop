FROM alpine:edge as novnc

RUN apk add wget unzip
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.zip
RUN unzip v1.2.0.zip
RUN wget https://github.com/novnc/websockify/archive/refs/tags/v0.9.0.zip
RUN unzip v0.9.0.zip
RUN mv websockify-0.9.0 websockify
RUN mv noVNC-1.2.0 novnc
RUN mv websockify novnc/utils/
RUN cd novnc && cp vnc.html index.html
RUN mv novnc /

FROM alpine:edge

ENV VNC_RESOLUTION=1280x1024x24
ENV VNC_PORT=5900
ENV NOVNC_PORT=6901

RUN apk add --no-cache \
        xfce4 \
        xfce4-terminal \
        faenza-icon-theme \
        sudo \
        curl \
        x11vnc \
        firefox \
        xvfb \
        # noVNC Requirements
        bash \
        python2 && \
    # Chinese font display
    apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        wqy-zenhei && \
    # Delete Power manager plugin
    rm -f /usr/share/xfce4/panel/plugins/power-manager-plugin.desktop && \
    rm -f /usr/share/applications/xfce4-power-manager-settings.desktop && \
    rm -f /usr/lib/xfce4/panel/plugins/libxfce4powermanager.so && \
    rm -f /etc/xdg/autostart/xfce4-power-manager.desktop && \
    mkdir /vnc/

WORKDIR /vnc/
COPY --from=novnc /novnc /vnc/novnc

COPY scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/bin/sh" ]
CMD [ "/entrypoint.sh" ]
