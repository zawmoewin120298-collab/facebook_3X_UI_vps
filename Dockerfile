# 🔑 MHSanaei ၏ တရားဝင် Base Image ကို ယူခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Cloudflare Tunnel မောင်းနှင်ရန် တရားဝင် Binary အား တိုက်ရိုက် ရယူခြင်း
COPY --from=cloudflare/cloudflared:latest /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# Container အတွင်းပိုင်း 3X-UI အတွက် Port အား ၂၀၅၃ ဟု ပိတ်ချုပ်ခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"
EXPOSE 2053

# 🚀 မူရင်း x-ui ပတ်လမ်းကြောင်းထဲသို့ သေချာဝင်ပြီးမှ Panel ရော Tunnel ပါ တွဲမောင်းမည့် စနစ်
RUN echo '#!/bin/bash\n\
echo "=== Pre-configuring 3X-UI ==="\n\
./x-ui setting -username admin -password admin\n\
./x-ui setting -port 2053\n\
./x-ui setting -webBasePath "/"\n\
\n\
echo "=== Starting 3X-UI Panel ==="\n\
./x-ui &\n\
sleep 4\n\
\n\
echo "=== Starting Cloudflare Tunnel ==="\n\
exec cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}' > /usr/local/x-ui/start_all.sh && chmod +x /usr/local/x-ui/start_all.sh

# 📌 အရေးကြီးဆုံးအပိုင်း- x-ui ရဲ့ မူရင်းလမ်းကြောင်းပေါ်မှာ အသေရပ်ပြီးမှ Script ကို မောင်းနှင်ခြင်း
WORKDIR /usr/local/x-ui
CMD ["./start_all.sh"]

