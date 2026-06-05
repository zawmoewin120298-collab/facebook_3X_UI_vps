# 🔑 MHSanaei ၏ တရားဝင် Base Image ကို ပြောင်းလဲခြင်းမရှိဘဲ တိုက်ရိုက်ယူခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Cloudflare Tunnel မောင်းနှင်ရန် တရားဝင် Binary အား /usr/local/bin ထဲသို့ ကွက်တိရယူခြင်း
COPY --from=cloudflare/cloudflared:latest /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# Container အတွင်းပိုင်း ပတ်ဝန်းကျင် တန်ဖိုးများကို အသေကြေညာခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"
EXPOSE 2053

# 🚀 မူရင်း entrypoint ကို မထိခိုက်စေဘဲ အနောက်ကွယ်မှ Tunnel ကို အမှားအယွင်းမရှိ ပူးတွဲမောင်းနှင်မည့် Startup Script
RUN echo '#!/bin/bash\n\
echo "=== Booting Cloudflare Tunnel in Background ==="\n\
if [ -z "${TUNNEL_TOKEN}" ]; then\n\
  echo "ERROR: TUNNEL_TOKEN is missing in Railway Variables!"\n\
else\n\
  cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} &\n\
fi\n\
\n\
echo "=== Handing over to Original 3X-UI Entrypoint ==="\n\
exec /usr/bin/tini -- /app/entrypoint.sh' > /railway_entrypoint.sh && chmod +x /railway_entrypoint.sh

# 📌 မူရင်း လမ်းကြောင်းများနှင့် အလုပ်လုပ်ပုံကို မထိခိုက်စေရန် ၎င်းနေရာတွင်သာ ရပ်တည်ခြင်း
ENTRYPOINT ["/railway_entrypoint.sh"]
