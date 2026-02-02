#!/bin/sh
# Start Xray in the background
/usr/bin/xray -config /etc/xray/config.json &

# Start Cloudflare Tunnel
cloudflared tunnel --no-autoupdate run --token eyJhIjoiOGQxZmJmOGJjOWM1NmFkOGYyMjZhMGM1MmNlZjgxNzIiLCJ0IjoiNzUxZDRmNTctMzZmMC00ODMwLTlmMWItNjc5ZTI0NzlmMzc3IiwicyI6Ilpqa3hNR0ZsTXpFdFpqSXlNeTAwWldGakxXRXhOV0V0TmpNeVlUTTFPR1U0TVRNeSJ9
