#!/bin/bash
# PostToolUse hook: runs dotnet test after file edits to .cs or .cshtml files
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.toolName')

# Only trigger after file edit operations
if [[ "$TOOL_NAME" != *"edit"* && "$TOOL_NAME" != *"create"* && "$TOOL_NAME" != *"replace"* && "$TOOL_NAME" != *"write"* ]]; then
  exit 0
fi

# Check if the edited file is a PolicyFlow source file
FILE_PATH=$(echo "$INPUT" | jq -r '.toolArgs.filePath // .toolArgs.path // ""')
if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

if [[ "$FILE_PATH" != *.cs && "$FILE_PATH" != *.cshtml ]]; then
  exit 0
fi

# Run the tests
cd "$(git rev-parse --show-toplevel 2>/dev/null || echo ".")"
TEST_OUTPUT=$(dotnet test tests/PolicyFlow.Tests --no-restore --verbosity quiet 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  echo "{\"systemMessage\": \"Tests failed after editing $FILE_PATH. Output:\\n$TEST_OUTPUT\"}"
else
  PASSED=$(echo "$TEST_OUTPUT" | grep -oP 'Passed:\s+\K\d+' || echo "all")
  echo "{\"systemMessage\": \"Tests passed ($PASSED) after editing $FILE_PATH.\"}"
fi
