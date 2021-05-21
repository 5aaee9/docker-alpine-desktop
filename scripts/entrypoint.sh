#!/bin/sh

/usr/bin/Xvfb :0 -screen 0 $VNC_RESOLUTION &

if [ "$VNC_PASSWORD" = "" ]; then
    VNC_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8 ; echo '')

    echo "Generate random password: $VNC_PASSWORD"
fi

cat > request_password <<EOF
$VNC_PASSWORD
$VNC_PASSWORD
y
EOF

x11vnc -storepasswd < request_password
rm -f request_password

mv /root/.vnc/passwd /vnc/passwd

chmod +x /vnc/.Xauthority

DISPLAY=":0" /usr/bin/startxfce4 &

/vnc/novnc/utils/launch.sh --vnc 127.0.0.1:$VNC_PORT --listen $NOVNC_PORT &

x11vnc -xkb -noxrecord -noxfixes -noxdamage \
    -display :0 -loop -shared -forever -bg \
    -rfbport $VNC_PORT \
    -rfbauth /vnc/passwd
