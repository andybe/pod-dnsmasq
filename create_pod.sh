#!/bin/sh
podman run -d -p 53:53/tcp -p 53:53/udp -v $(pwd)/dnsmasq.d/:/etc/dnsmasq.d/ --name dnsmasq dnsmasq:latest
# podman generate systemd  --restart-policy always  --name dnsmasq > /etc/systemd/system/container-dnsmasq.service
