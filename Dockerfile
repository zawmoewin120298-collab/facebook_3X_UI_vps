FROM ubuntu:22.04

# လိုအပ်သော Linux Tools များ တပ်ဆင်ခြင်း
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl bash tzdata sqlite3 && rm -rf /var/lib/apt/lists/*

# 🔑 MHSanaei 3X-UI နောက်ဆုံးဗားရှင်း Script ဖြင့် တပ်ဆင်ခြင်း
RUN bash -c "$(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)"

# Railway အတွက် Port ကြေညာခြင်း
ENV PORT=2053
EXPOSE 2053

# 🛠 404 လုံးဝမတက်စေရန် Database ထဲသို့ Port (2053) နှင့် Path ("/") ကို တိုက်ရိုက် Injection လုပ်ပြီး အသေထည့်ခြင်း
RUN mkdir -p /etc/x-ui/ && \
    sqlite3 /etc/x-ui/x-ui.db "CREATE TABLE IF NOT EXISTS settings (id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT UNIQUE, value TEXT);" && \
    sqlite3 /etc/x-ui/x-ui.db "INSERT OR REPLACE INTO settings (key, value) VALUES ('webPort', '2053');" && \
    sqlite3 /etc/x-ui/x-ui.db "INSERT OR REPLACE INTO settings (key, value) VALUES ('webBasePath', '/');" && \
    sqlite3 /etc/x-ui/x-ui.db "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE, password TEXT);" && \
    sqlite3 /etc/x-ui/x-ui.db "INSERT OR REPLACE INTO users (id, username, password) VALUES (1, 'admin', 'admin');"

# ရိုးရှင်းစွာ ရှေ့တန်းကနေ တိုက်ရိုက် ခေါ်မောင်းခြင်း
WORKDIR /usr/local/x-ui
CMD ["./x-ui"]

