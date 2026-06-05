# 🔑 MHSanaei ၏ တရားဝင် Base Image ကို တိုက်ရိုက်သုံးခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Cloudflare Tunnel Binary အား စနစ်တကျ ရယူခြင်း
COPY --from=cloudflare/cloudflared:latest /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# Container အတွင်းပိုင်း ပတ်ဝန်းကျင် တန်ဖိုးများ ပိတ်ချုပ်ခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"
EXPOSE 2053

# 🚀 Script ဖိုင်ဆောက်မနေတော့ဘဲ တစ်ကြောင်းတည်းဖြင့် အလုပ်လုပ်ခိုင်းခြင်း (Line Ending Error ကင်းဝေးစေရန်)
# Cloudflared ကို အနောက်ကွယ်မှာ ပတ်စေပြီး 3X-UI ၏ မူရင်း Entrypoint အား တိုက်ရိုက် မောင်းနှင်စေပါသည်
CMD ["/bin/sh", "-c", "cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} & exec /usr/bin/tini -- /app/entrypoint.sh"]

