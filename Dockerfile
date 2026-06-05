FROM ubuntu:22.04

# လိုအပ်သော Linux Tool များ အရင်ဆုံး တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# 🔑 MHSanaei 3X-UI နောက်ဆုံးဗားရှင်း Script ဖြင့် တပ်ဆင်ခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# Railway အတွက် Port ကို 2053 သို့ အသေ သတ်မှတ်ခြင်း
ENV PORT=2053
EXPOSE 2053

# 404 အမှား မတက်စေရန် Panel ၏ Base Path ကို အလွတ် ( Root "/" ) သို့ အဓမ္မ ပြောင်းလဲခြင်း
# Panel Port ကိုလည်း Railway ဖတ်နိုင်မည့် 2053 သို့ တစ်ခါတည်း သတ်မှတ်ခြင်း
RUN /usr/local/x-ui/x-ui setting -username admin -password admin \
    && /usr/local/x-ui/x-ui setting -port 2053 \
    && /usr/local/x-ui/x-ui setting -webBasePath ""

# MHSanaei Core ရှိရာ လမ်းကြောင်းသို့ ပြောင်းရွှေ့ပြီး တိုက်ရိုက် မောင်းနှင်ခြင်း
WORKDIR /usr/local/x-ui
CMD ["./x-ui"]

