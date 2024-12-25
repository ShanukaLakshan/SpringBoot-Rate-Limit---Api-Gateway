#!/bin/bash

# URL of the API Gateway endpoint
URL="http://localhost:8082/hello"

# Number of requests to send
REQUEST_COUNT=20

echo "Sending $REQUEST_COUNT requests to $URL..."
echo "---------------------------------------"

# Loop to send requests
for i in $(seq 1 $REQUEST_COUNT)
do
  RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" $URL)
  
  if [ "$RESPONSE" -eq 200 ]; then
    echo "Request $i: ✅ Allowed (200 OK)"
  elif [ "$RESPONSE" -eq 429 ]; then
    echo "Request $i: 🚫 Rate Limited (429 Too Many Requests)"
  else
    echo "Request $i: ❓ Unexpected Response ($RESPONSE)"
  fi
done

echo "---------------------------------------"
echo "Test completed!"
