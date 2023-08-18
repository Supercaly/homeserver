FROM debian:stable-slim

WORKDIR /

ARG API_URL
ARG API_KEY

ENV API_URL $API_URL
ENV API_KEY $API_KEY

RUN apt update \
    && apt install curl -y \
    && curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | bash \
    && apt install crowdsec-firewall-bouncer-iptables -y \
    && apt install -y gettext \
    && rm -rf /var/lib/apt/lists/* 

COPY crowdsec-firewall-bouncer.yaml .

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"] 
CMD ["crowdsec-firewall-bouncer", "-c", "/bouncer_config.yaml"]