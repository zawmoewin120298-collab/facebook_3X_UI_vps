FROM ubuntu:22.04

# လိုအပ်သော Linux Tools များအား တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# 🔑 MHSanaei 3X-UI နောက်ဆုံးဗားရှင်း Script ဖြင့် တပ်ဆင်ခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# Railway အတွက် Port ကြေညာခြင်း
ENV PORT=2053
EXPOSE 2053

# ဆာဗာစတင်ချိန်တွင် Database ထဲက လမ်းကြောင်းနှင့် Port အားလုံးကို Root (/) သို့ အတင်းဝင်ပြင်ပေးမည့် Startup Script ဆောက်ခြင်း
RUN echo '#!/bin/bash\n\
/usr/local/x-ui/x-ui setting -username admin -password admin\n\
/usr/local/x-ui/x-ui setting -port 2053\n\
/usr/local/x-ui/x-ui setting -webBasePath ""\n\
cd /usr/local/x-ui\n\
exec ./x-ui' > /usr/local/x-ui/start.sh && chmod +x /usr/local/x-ui/start.sh

# မောင်းနှင်မည့် လမ်းကြောင်းသတ်မှတ်ခြင်း
WORKDIR /usr/local/x-ui
CMD ["./start.sh"]

