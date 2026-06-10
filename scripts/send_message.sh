#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

source "$REPO_ROOT/.env"

PROMPT="${1:-Hello}"

mkdir -p "$LOG_DIR"

# Keep only last 7 days of logs
find "$LOG_DIR" \
    -type f \
    -name "*.log" \
    -mtime +7 \
    -delete

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOGFILE="$LOG_DIR/$(date '+%Y-%m-%d').log"

{
    echo ""
    echo "=================================================="
    echo "Timestamp: $TIMESTAMP"
    echo "Prompt: $PROMPT"
    echo "=================================================="

    curl --silent \
        --request POST \
        --url https://api.anthropic.com/v1/messages \
        --header "x-api-key: $ANTHROPIC_API_KEY" \
        --header "anthropic-version: 2023-06-01" \
        --header "content-type: application/json" \
        --data "{
            \"model\": \"$MODEL\",
            \"max_tokens\": 512,
            \"messages\": [
                {
                    \"role\": \"user\",
                    \"content\": \"$PROMPT\"
                }
            ]
        }"

    echo ""
    echo ""
} >> "$LOGFILE" 2>&1
