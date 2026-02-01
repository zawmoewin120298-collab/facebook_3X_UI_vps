FROM alpine:latest

# လိုအပ်တဲ့ package များ သွင်းခြင်း
RUN apk add --no-cache curl bash python3

# 3X-UI တိုက်ရိုက်သွင်းသည့် script
RUN curl -Ls https://raw.githubusercontent.com/mzzfz/3x-ui/master/install.sh | bash

WORKDIR /usr/local/x-ui

# Port 8080 ကို ပုံသေ သတ်မှတ်ခြင်း
ENV X_UI_PORT=8080
EXPOSE 8080

# Panel ကို စတင်မောင်းနှင်ခြင်း
CMD ["./x-ui"]
