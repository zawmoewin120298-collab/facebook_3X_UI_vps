# 🔑 MHSanaei ၏ တရားဝင် Base Image ကို တိုက်ရိုက်သုံးခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Cloudflare Tunnel Binary အား စနစ်တကျ ရယူခြင်း
COPY --from=cloudflare/cloudflared:latest /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# Container အတွင်းပိုင်း ပတ်ဝန်းကျင် တန်ဖိုးများ ပိတ်ချုပ်ခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"
EXPOSE 2053

# 🚀 မူရင်း Entrypoint ဖိုင်တွေကို လိုက်မပြင်တော့ဘဲ wrapper script တစ်ခုကို သီးသန့်ဆောက်ခြင်း
# ၎င်း wrapper ထဲကနေ tunnel ကို အရင်မောင်းပြီးမှ မူရင်းစနစ်ကို အမှားကင်းကင်း ပြန်ဆင့်ခေါ်ပါသည်
RUN echo '#!/bin/sh\n\
echo "=== Booting Cloudflare Tunnel ==="\n\
cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} &\n\
sleep 2\n\
echo "=== Delegating to Original Container Process ==="\n\
exec /usr/local/bin/x-ui-daemon' > /entrywrapper.sh && chmod +x /entrywrapper.sh

# မူရင်း ENTRYPOINT ကို လမ်းလွှဲပြီး ကျွန်တော်တို့ Script အား အရှေ့တန်းမှ တင်မောင်းခြင်း
ENTRYPOINT ["/entrywrapper.sh"]

