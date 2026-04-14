#!/bin/bash
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.toolName')
TOOL_ARGS=$(echo "$INPUT" | jq -r '.toolArgs')

echo "$(date): TOOL=$TOOL_NAME ARGS=$TOOL_ARGS" >> .github/hooks/tool-usage.log

if echo "$TOOL_ARGS" | grep -qE "rm -rf /|DROP TABLE|DELETE FROM Expenses|format c:"; then
  echo '{"permissionDecision":"deny","permissionDecisionReason":"Dangerous command detected. PolicyFlow demo blocks destructive operations."}'
  exit 0
fi

echo '{"permissionDecision":"allow"}'
