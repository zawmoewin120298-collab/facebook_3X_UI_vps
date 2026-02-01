FROM alpine:latest

# Install 3X-UI
RUN apk add --no-cache curl bash && \
    bash <(curl -Ls https://raw.githubusercontent.com/mzzfz/3x-ui/master/install.sh)

# Set the working directory
WORKDIR /usr/local/x-ui

# Port 8080 ကို ပုံသေသုံးရန် (Cloudflare Tunnel နဲ့ အကိုက်ညီဆုံးဖြစ်အောင်)
ENV X_UI_PORT=8080

# Expose the port
EXPOSE 8080

# Start 3X-UI
CMD ["./x-ui"]
