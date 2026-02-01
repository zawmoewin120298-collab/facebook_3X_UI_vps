FROM alpine:latest

# လိုအပ်တဲ့ package တွေသွင်းပြီး 3X-UI ကို တန်းတင်ပါမယ်
RUN apk add --no-cache curl bash python3 && \
    mkdir -p /etc/x-ui && \
    curl -Ls https://raw.githubusercontent.com/MHSanaei/3x-ui/master/install.sh | bash

WORKDIR /usr/local/x-ui

# Railway Port Setting
ENV X_UI_PORT=8080
EXPOSE 8080

# Panel ကို စတင်မောင်းနှင်ခြင်း
CMD ["./x-ui"]
