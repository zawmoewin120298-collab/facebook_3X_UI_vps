FROM ubuntu:22.04

# လိုအပ်သော Linux Tools များ တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl bash tzdata && rm -rf /var/lib/apt/lists/*

# 🔑 MHSanaei 3X-UI နောက်ဆုံးဗားရှင်း Script ဖြင့် တပ်ဆင်ခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# 3X-UI Core စနစ်က အလိုအလျောက်ဖတ်မည့် Native Environment Variables များ အသေကြေညာခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH=""
ENV PORT=2053

# Railway အတွက် Port ဖွင့်ပေးခြင်း
EXPOSE 2053

# ဆာဗာစတင်ချိန်တွင် CLI ဖြင့် အကောင့်ကို အရင်သတ်မှတ်ပြီး Core ကို ရှေ့တန်းကနေ တိုက်ရိုက်မောင်းနှင်ခြင်း
WORKDIR /usr/local/x-ui
CMD ["/bin/bash", "-c", "./x-ui setting -username admin -password admin && exec ./x-ui"]

