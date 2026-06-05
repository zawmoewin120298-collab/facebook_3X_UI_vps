FROM ubuntu:22.04

# လိုအပ်သော Linux Tools များ အရင်ဆုံး တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl bash tzdata && rm -rf /var/lib/apt/lists/*

# 🔑 MHSanaei 3X-UI နောက်ဆုံးဗားရှင်း Script ဖြင့် တပ်ဆင်ခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# Railway အတွက် Port ကြေညာခြင်း
ENV PORT=2053
EXPOSE 2053

# 🛠 3X-UI Database ကို ဘယ်နေရာမှာပဲဆောက်ဆောက် CLI ဖြင့် အမိန့်တော်ပြန်ပြီး Port 2053 သို့ အတင်းပြောင်းမည့် စနစ်သစ်
RUN echo '#!/bin/bash\n\
cd /usr/local/x-ui\n\
./x-ui &\n\
PID=$!\n\
sleep 4\n\
./x-ui setting -username admin -password admin\n\
./x-ui setting -port 2053\n\
./x-ui setting -webBasePath ""\n\
echo "=== 3X-UI Configurations Overridden. Restarting Core to Apply... ==="\n\
kill $PID\n\
sleep 2\n\
exec ./x-ui' > /usr/local/x-ui/entrypoint.sh && chmod +x /usr/local/x-ui/entrypoint.sh

# ပင်မလမ်းကြောင်း သတ်မှတ်ပြီး မောင်းနှင်ခြင်း
WORKDIR /usr/local/x-ui
CMD ["./entrypoint.sh"]

