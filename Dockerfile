FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl wget bash unzip ca-certificates

# 3x-ui ကို direct binary နဲ့ သွင်းခြင်း
RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
    wget https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-${arch}.tar.gz && \
    tar zxvf x-ui-linux-${arch}.tar.gz && \
    rm x-ui-linux-${arch}.tar.gz && \
    mv x-ui /usr/local/ && \
    chmod +x /usr/local/x-ui/x-ui

# cloudflared သွင်းခြင်း
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 443
CMD ["/start.sh"]
