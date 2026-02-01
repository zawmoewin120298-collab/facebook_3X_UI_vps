#!/bin/bash

echo "Starting 3x-ui..."
cd /usr/local/x-ui/
# x-ui ကို background မှာ run မယ်
./x-ui &

sleep 5

echo "Starting Cloudflare Tunnel..."
# Token နဲ့ --token ကြားမှာ Space ခြားဖို့ မမေ့ပါနဲ့
/usr/local/bin/cloudflared tunnel --no-autoupdate run --token eyJhIjoiOGQxZmJmOGJjOWM1NmFkOGYyMjZhMGM1MmNlZjgxNzIiLCJ0IjoiNzUxZDRmNTctMzZmMC00ODMwLTlmMWItNjc5ZTI0NzlmMzc3IiwicyI6Ilpqa3hNR0ZsTXpFdFpqSXlNeTAwWldGakxXRXhOV0V0TmpNeVlUTTFPR1U0TVRNeSJ9
