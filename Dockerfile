FROM ghcr.io/mhsanaei/3x-ui:latest

# Railway အတွက် Port Setting
ENV X_UI_PORT=8080
EXPOSE 8080

# Panel ကို စတင်မောင်းနှင်ခြင်း
CMD ["./x-ui"]
