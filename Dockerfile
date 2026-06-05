FROM ubuntu:22.04

# လိုအပ်သော Linux Tool များ အရင်ဆုံး တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    supervisor \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# 🔑 ဆရာကြီးပေးသော MHSanaei 3X-UI Update အသစ်ဖြင့် တပ်ဆင်ခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# Railway အတွက် Port သတ်မှတ်ခြင်း
ENV PORT=2053
EXPOSE 2053

# Panel အား Background တွင် အမြဲတမ်း ပတ်ထားပေးရန် Supervisor ဆောက်ခြင်း
RUN mkdir -p /etc/supervisor/conf.d/ \
    && echo "[program:3x-ui]\n\
command=/usr/local/3x-ui/3x-ui\n\
autostart=true\n\
autorestart=true\n\
user=root\n\
stdout_logfile=/dev/stdout\n\
stdout_logfile_maxbytes=0\n\
stderr_logfile=/dev/stderr\n\
stderr_logfile_maxbytes=0" > /etc/supervisor/conf.d/3x-ui.conf

# စနစ်စတင်မောင်းနှင်ရန် အမိန့်စာ
CMD ["/usr/bin/supervisord", "-n"]

