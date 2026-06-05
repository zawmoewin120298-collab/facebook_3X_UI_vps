FROM alpine:latest

# လိုအပ်သော Packages များနှင့် 3X-UI နောက်ဆုံးဗားရှင်းကို ရယူခြင်း
RUN apk update && apk add --no-cache curl bash supervisor \
    && bash -c "$(curl -Ls https://raw.githubusercontent.com/maciDrop/XrayR-release/master/3x-ui.sh)" \
    && echo "3x-ui installed successfully"

# Supervisor Configuration ဆောက်ခြင်း (Panel အား နောက်ကွယ်တွင် ပတ်ထားရန်)
RUN mkdir -p /etc/supervisor.d/
RUN echo -e "[program:3x-ui]\ncommand=/usr/local/3x-ui/3x-ui\nautostart=true\nautorestart=true\nuser=root" > /etc/supervisor.d/3x-ui.ini

# Port ဖွင့်ပေးခြင်း (Railway အတွက် Internal Port)
EXPOSE 2053

# Panel အား အမြဲတမ်း ပတ်ထားစေမည့် စနစ်
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
