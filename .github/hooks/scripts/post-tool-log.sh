#!/bin/bash
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.toolName')
RESULT_TYPE=$(echo "$INPUT" | jq -r '.toolResult.resultType // "unknown"')
RESULT_TEXT=$(echo "$INPUT" | jq -r '.toolResult.textResultForLlm // ""' | head -c 200)

echo "$(date),$TOOL_NAME,$RESULT_TYPE,\"$RESULT_TEXT\"" >> .github/hooks/tool-results.csv
