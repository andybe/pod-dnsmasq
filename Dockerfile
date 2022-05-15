FROM alpine:latest

RUN apk add --update --no-cache dnsmasq; \
    rm -f /var/cache/apk/*

ADD dns_file_changed.sh /usr/local/bin/dns_file_changed.sh

EXPOSE 53

ENTRYPOINT ["ash","-c","/usr/local/bin/dns_file_changed.sh"]

# podman build -t dnsmasq .
