# 🔑 MHSanaei ၏ တရားဝင် GitHub Registry Base Image ကို အသုံးပြုခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Cloudflare Tunnel မောင်းနှင်ရန် တရားဝင် Binary အား တိုက်ရိုက် ရယူခြင်း
COPY --from=cloudflare/cloudflared:latest /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# Container အတွင်းပိုင်း 3X-UI အတွက် Port အား ၂၀၅၃ ဟု ပိတ်ချုပ်ခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"
EXPOSE 2053

# 🚀 Folder မရှိသည့် အမှားကို ကျော်ရန် root "/" ထဲတွင်သာ Script အသေဆောက်ခြင်း
# ပတ်ဝန်းကျင် လမ်းကြောင်း ပျောက်ဆုံးမှုမရှိစေရန် အကုန်လုံးကို Absolute Path ဖြင့် ပိတ်ချုပ်မောင်းနှင်ပါသည်
RUN echo '#!/bin/bash\n\
echo "=== Pre-configuring 3X-UI ==="\n\
x-ui setting -username admin -password admin\n\
x-ui setting -port 2053\n\
x-ui setting -webBasePath "/"\n\
\n\
echo "=== Starting 3X-UI Panel ==="\n\
x-ui &\n\
sleep 4\n\
\n\
echo "=== Starting Cloudflare Tunnel ==="\n\
exec cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}' > /start_all.sh && chmod +x /start_all.sh

# ပင်မ အလုပ်လုပ်မည့် နေရာကို သတ်မှတ်ပြီး Script အား အရှေ့တန်းမှ မောင်းနှင်ခြင်း
WORKDIR /
CMD ["/start_all.sh"]

