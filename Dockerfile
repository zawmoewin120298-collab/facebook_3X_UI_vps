FROM ubuntu:22.04

# လိုအပ်သော Linux Tool များ တစ်ခါတည်း သတ်မှတ်တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    supervisor \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# 🔑 တရားဝင် 3X-UI (FranzKafkaYu) Script အမှန်ဖြင့် အဆင့်မြင့်တပ်ဆင်ခြင်း
RUN bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# Railway အတွက် Port ကြေညာခြင်း
ENV PORT=2053
EXPOSE 2053

# Panel နှင့် Xray Core အား နောက်ကွယ်တွင် အမြဲပတ်ထားရန် Supervisor ဖန်တီးခြင်း
RUN mkdir -p /etc/supervisor/conf.d/ \
    && echo "[program:x-ui]\n\
command=/usr/local/x-ui/x-ui\n\
autostart=true\n\
autorestart=true\n\
user=root\n\
stdout_logfile=/dev/stdout\n\
stdout_logfile_maxbytes=0\n\
stderr_logfile=/dev/stderr\n\
stderr_logfile_maxbytes=0" > /etc/supervisor/conf.d/x-ui.conf

# စနစ်အား စတင်မောင်းနှင်ရန် အမိန့်
CMD ["/usr/bin/supervisord", "-n"]

