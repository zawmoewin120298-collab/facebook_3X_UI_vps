# cloudflared ကို dynamic architecture နဲ့ သွင်းခြင်း
RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${arch} -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared
