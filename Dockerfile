# 🔑 MHSanaei ၏ တရားဝင် GitHub Registry ဗားရှင်းကို ဆက်သုံးခြင်း
FROM ghcr.io/mhsanaei/3x-ui:latest

# Railway Proxy စနစ်အတွက် Port 8080 အသေကြေညာခြင်း
ENV PORT=8080
EXPOSE 8080

# 🛠 Config ထောင်ချောက်များကို ကျော်ရန် ပတ်ဝန်းကျင် Variables များ ကြေညာခြင်း
ENV XUI_PORT=8080
ENV XUI_WEB_BASE_PATH="/"

# 🚀 Background တွင် ငြိမ်မနေစေရန် Core ကို အရှေ့တန်းမှ အတင်းဆွဲမောင်းမည့် စနစ်
WORKDIR /usr/local/x-ui
CMD ["/bin/bash", "-c", "./x-ui setting -username admin -password admin && ./x-ui setting -port 8080 && ./x-ui setting -webBasePath \"\" && exec ./x-ui"]

