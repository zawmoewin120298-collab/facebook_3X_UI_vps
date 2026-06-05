# 🔑 MHSanaei ၏ တရားဝင် GitHub မှ ပံ့ပိုးထားသော Official Docker Image အား တိုက်ရိုက်ခေါ်သုံးခြင်း
FROM mhsanaei/3x-ui:latest

# Railway Proxy နှင့် အဆင်ပြေဆုံးဖြစ်စေရန် ပတ်ဝန်းကျင် Port အား 8080 ဟု သတ်မှတ်ခြင်း
ENV PORT=8080
EXPOSE 8080

# 🛠 MHSanaei Core မှ အလိုအလျောက်ဖတ်မည့် တရားဝင် Environment Variables များ
# ၎င်း variables များကြောင့် database ထဲတွင် random path ပြောင်းလဲခြင်းကို လုံးဝတားဆီးပေးပါသည်
ENV XUI_PORT=8080
ENV XUI_WEB_BASE_PATH="/"

