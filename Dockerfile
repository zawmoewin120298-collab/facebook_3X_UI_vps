# 🔑 MHSanaei ၏ တရားဝင် Base Image ကို တိုက်ရိုက်သုံးခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Cloudflare Tunnel Binary အား စနစ်တကျ ရယူခြင်း
COPY --from=cloudflare/cloudflared:latest /usr/local/bin/cloudflared /usr/local/bin/cloudflared

# Container အတွင်းပိုင်း ပတ်ဝန်းကျင် တန်ဖိုးများ ပိတ်ချုပ်ခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"
EXPOSE 2053

# 🚀 မူရင်း entrypoint.sh ရဲ့ ဒုတိယစာကြောင်းမှာ cloudflared command ကို အတင်းသွားညှပ်ထည့်သည့် ဗျူဟာ
# ဒါဆိုရင် မူရင်းစနစ်လည်း မပျက်ဘဲ Tunnel လည်း (၁၀၀%) အနောက်ကွယ်ကနေ တန်းပတ်မှာဖြစ်ပါတယ်
RUN sed -i '2i cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} &' /app/entrypoint.sh

# မူရင်း လုပ်ငန်းစဉ်အတိုင်း တရားဝင် ပြန်လည်လွှဲပြောင်းမောင်းနှင်ခြင်း
ENTRYPOINT ["/usr/bin/tini", "--", "/app/entrypoint.sh"]

