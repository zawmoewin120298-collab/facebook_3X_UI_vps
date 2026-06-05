FROM ubuntu:22.04

# လိုအပ်သော Linux Tool များ အရင်ဆုံး တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# 🔑 ဆရာကြီးပေးသော MHSanaei 3X-UI နောက်ဆုံးဗားရှင်း Script ဖြင့် တပ်ဆင်ခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# Railway အတွက် Port ကြေညာခြင်း
ENV PORT=2053
EXPOSE 2053

# MHSanaei Core ရှိရာ လမ်းကြောင်းအမှန်သို့ ပြောင်းရွှေ့ပြီး တိုက်ရိုက် မောင်းနှင်ခြင်း
WORKDIR /usr/local/x-ui
CMD ["./x-ui"]

