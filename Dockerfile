FROM ghcr.io/mhsanaei/3x-ui:latest

# Railway Port ကို 443 သို့ တိုက်ရိုက်ပြောင်းခြင်း
ENV X_UI_PORT=443
EXPOSE 443

CMD ["./x-ui"]
