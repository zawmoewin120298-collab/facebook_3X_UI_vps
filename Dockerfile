# 🔑 MHSanaei ၏ တရားဝင် GitHub Registry Base Image ကို အသုံးပြုခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Cloudflare Tunnel မောင်းနှင်ရန် တရားဝင် Binary အား တိုက်ရိုက် ရယူခြင်း
COPY --from=cloudflare/cloudflared:latest /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# Container အတွင်းပိုင်း 3X-UI အတွက် Port အား ၂၀၅၃ ဟု ပိတ်ချုပ်ခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"
EXPOSE 2053

# 🚀 3X-UI ကို အနောက်ကွယ်မှ မောင်းပြီး Cloudflare Tunnel ကို အရှေ့တန်းမှ အပိုင်ဆွဲမောင်းမည့် စနစ်
RUN echo '#!/bin/bash\n\
cd /usr/local/x-ui\n\
./x-ui &\n\
sleep 3\n\
echo "=== Starting Cloudflare Tunnel ==="\n\
exec cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}' > /usr/local/x-ui/start_all.sh && chmod +x /usr/local/x-ui/start_all.sh

WORKDIR /usr/local/x-ui
CMD ["./start_all.sh"]

