FROM ghcr.io/mhsanaei/3x-ui:latest

# Cloudflare Tunnel မောင်းရန် လိုအပ်သော Linux Tools များ ထည့်သွင်းခြင်း
RUN apt-get update && apt-get install -y curl wget exact bash && rm -rf /var/lib/apt/lists/*

# Cloudflare Tunnel (cloudflared) အား နောက်ဆုံးဗားရှင်း ဒေါင်းလုဒ်ဆွဲပြီး တပ်ဆင်ခြင်း
RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

# Container အတွင်းပိုင်း 3X-UI အတွက် Port အသေကြေညာခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"
EXPOSE 2053

# 🚀 3X-UI ရော Cloudflare Tunnel ပါ တစ်ပြိုင်နက်တည်း အမှားအယွင်းမရှိ ရှေ့တန်းကနေ တွဲမောင်းမည့် စနစ်
RUN echo '#!/bin/bash\n\
cd /usr/local/x-ui\n\
./x-ui &\n\
sleep 2\n\
echo "=== Starting Cloudflare Tunnel ==="\n\
exec cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}' > /usr/local/x-ui/start_all.sh && chmod +x /usr/local/x-ui/start_all.sh

WORKDIR /usr/local/x-ui
CMD ["./start_all.sh"]

