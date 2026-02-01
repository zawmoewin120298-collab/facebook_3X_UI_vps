#!/bin/bash

echo "Starting 3x-ui..."
cd /usr/local/x-ui/
./x-ui &

sleep 5

echo "Starting Cloudflare Tunnel..."
# သင့်ရဲ့ Token ကို ဒီနေရာမှာ တိုက်ရိုက်ထည့်ပေးထားပါတယ်
/usr/local/bin/cloudflared tunnel --no-autoupdate run --token 
eyJhIjoiOGQxZmJmOGJjOWM1NmFkOGYyMjZhMGM1MmNlZjgxNzIiLCJ0IjoiNzUxZDRmNTctMzZmMC00ODMwLTlmMWItNjc5ZTI0NzlmMzc3IiwicyI6Ilpqa3hNR0ZsTXpFdFpqSXlNeTAwWldGakxXRXhOV0V0TmpNeVlUTTFPR1U0TVRNeSJ9
