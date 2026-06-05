# 🔑 MHSanaei ၏ တရားဝင် GitHub Registry လမ်းကြောင်းအမှန်မှ Image ကို ဆွဲယူခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Railway Proxy နှင့် အကိုက်ညီဆုံးဖြစ်စေရန် Internal Port ကို 8080 ဟု သတ်မှတ်ခြင်း
ENV PORT=8080
EXPOSE 8080

# 🛠 Database ထဲတွင် Random Path များ လျှောက်မဆောက်စေရန် ပတ်ဝန်းကျင်အဆင့်မှာတင် အသေပိတ်ချုပ်ခြင်း
ENV XUI_PORT=8080
ENV XUI_WEB_BASE_PATH="/"
