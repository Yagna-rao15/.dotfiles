#!/bin/bash

response=$(curl -s http://localhost:11434/api/generate -d '{
  "model": "llama3.1:8b",
  "prompt": "Tell me small story of 50 words"
}' | jq -r '.response')

single_line_response=$(echo "$response" | tr '\n' ' ')

echo "## Output"
echo "$single_line_response"

