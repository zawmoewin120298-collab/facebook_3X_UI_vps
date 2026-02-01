FROM alpine:latest

# လိုအပ်သော Tools များသွင်းခြင်း
RUN apk add --no-cache curl bash python3

# 3X-UI ကို တိုက်ရိုက်သွင်းခြင်း
RUN bash <(curl -Ls https://raw.githubusercontent.com/mzzfz/3x-ui/master/install.sh)

WORKDIR /usr/local/x-ui

# Railway အတွက် Port Setting
ENV X_UI_PORT=8080
EXPOSE 8080

# Panel ကို စတင်မောင်းနှင်ခြင်း
CMD ["./x-ui"]
