FROM ghcr.io/mhsanaei/3x-ui:latest

# Railway အတွက် Port ကို 2053 သတ်မှတ်ခြင်း
ENV X_UI_PORT=2053
EXPOSE 2053

CMD ["./x-ui"]
