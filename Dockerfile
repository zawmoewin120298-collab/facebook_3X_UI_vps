# 🔑 စကရစ်အသုံးပြုစရာမလိုဘဲ Core တစ်ခုလုံး အသင့်ပါပြီးသား တရားဝင် MHSanaei 3X-UI Docker Image ကို တိုက်ရိုက်ယူသုံးခြင်း
FROM mhsanaei/3x-ui:latest

# Railway အတွက် Port ကို အပိုင် သတ်မှတ်ပေးခြင်း
ENV PORT=2053
EXPOSE 2053

# Web Base Path ကို လုံးဝအလွတ် (Root "/") ဖြစ်အောင် Container အဆင့်မှာတင် ပိတ်ချုပ်ခြင်း
ENV XUI_PORT=2053
ENV XUI_WEB_BASE_PATH="/"

