FROM ubuntu:22.04

# လိုအပ်တဲ့ Tools တွေ အကုန်လုံးကို တစ်ခါတည်းသွင်းမယ်
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    bash \
    unzip \
    ca-certificates \
    && apt-get clean

# 3x-ui သွင်းခြင်း (amd64 အတွက် တိုက်ရိုက်ယူမယ်)
RUN wget https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz && \
    tar zxvf x-ui-linux-amd64.tar.gz && \
    rm x-ui-linux-amd64.tar.gz && \
    mv x-ui /usr/local/ && \
    chmod +x /usr/local/x-ui/x-ui

# cloudflared သွင်းခြင်း (amd64 အတွက် တိုက်ရိုက်ယူမယ်)
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

COPY start.sh /start.sh
RUN chmod +x /start.sh

# Railway အတွက် Port ဖွင့်ပေးခြင်း
EXPOSE 80
EXPOSE 2053

CMD ["/bin/bash", "/start.sh"]
