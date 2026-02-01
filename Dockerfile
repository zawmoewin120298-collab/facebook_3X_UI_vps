# Cloudflared ကို တိုက်ရိုက်ဆွဲချခြင်း (amd64 အတွက်)
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared
