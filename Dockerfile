FROM alpine:latest

# လိုအပ်သော Linux packages များအား တစ်ခါတည်း တပ်ဆင်ခြင်း
RUN apk update && apk add --no-cache curl bash supervisor tzdata

# 3X-UI Panel ကို တိုက်ရိုက် ရယူပြီး သတ်မှတ်ထားသော လမ်းကြောင်းထဲ ထည့်သွင်းခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/maciDrop/XrayR-release/master/3x-ui.sh)"

# Railway ပေါ်တွင် အလုပ်လုပ်နိုင်ရန် Port ကို 2053 သို့ အသေ သတ်မှတ်ခြင်း
ENV PORT=2053
EXPOSE 2053

# Panel အား Background တွင် အမြဲတမ်း ပတ်ထားပေးမည့် စနစ်အား ဖန်တီးခြင်း
RUN mkdir -p /etc/supervisor.d/ \
    && echo -e "[program:3x-ui]\ncommand=/usr/local/3x-ui/3x-ui\nautostart=true\nautorestart=true\nuser=root\nstdout_logfile=/dev/stdout\nstdout_logfile_maxbytes=0\nstderr_logfile=/dev/stderr\nstderr_logfile_maxbytes=0" > /etc/supervisor.d/3x-ui.ini

# Dashboard အား စတင်မောင်းနှင်ရန် အမိန့်စာ
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

