FROM ubuntu:22.04

# လိုအပ်သော Linux Tools များ တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl bash tzdata && rm -rf /var/lib/apt/lists/*

# 🔑 MHSanaei 3X-UI နောက်ဆုံးဗားရှင်း Script ဖြင့် တပ်ဆင်ခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# Railway အတွက် Port ကြေညာခြင်း
ENV PORT=2053
EXPOSE 2053

# 🛠 3X-UI မောင်းနှင်ပြီးနောက် ပိတ်ဆို့မှုအားလုံးကို CLI မှတစ်ဆင့် စက္ကန့်ပိုင်းအတွင်း အတင်းဝင်ပြင်မည့် ဉာဏ်ရည်တု Startup Script
RUN echo '#!/bin/bash\n\
cd /usr/local/x-ui\n\
./x-ui &\n\
PID=$!\n\
sleep 3\n\
./x-ui setting -username admin -password admin\n\
./x-ui setting -port 2053\n\
./x-ui setting -webBasePath ""\n\
echo "=== 3X-UI Configurations Overridden Successfully ==="\n\
wait $PID' > /usr/local/x-ui/entrypoint.sh && chmod +x /usr/local/x-ui/entrypoint.sh

# ပင်မလမ်းကြောင်း သတ်မှတ်ပြီး မောင်းနှင်ခြင်း
WORKDIR /usr/local/x-ui
CMD ["./entrypoint.sh"]

