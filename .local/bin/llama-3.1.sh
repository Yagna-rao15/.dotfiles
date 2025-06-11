#!/bin/bash

response=$(curl -s http://localhost:11434/api/generate -d '{
  "model": "llama3.1:8b",
  "prompt": "how to set ctab to cycle through tabs in nvim map("n", "<leader>tab", "<cmd>bNext<CR>", { desc = "buffer goto next" })"
}' | jq -r '.response')

single_line_response=$(echo "$response" | tr '\n' ' ')

echo "## Output"
echo "$single_line_response"
