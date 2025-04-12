#!/bin/bash
set -e

# Parse URLs from environment variables
LITELLM_HOST=$(echo "$OPENAI_API_BASE_URL" | sed -E 's|https?://([^:/]+).*|\1|')
LITELLM_PORT=$(echo "$OPENAI_API_BASE_URL" | sed -E 's|https?://[^:]+:?([0-9]+)?.*|\1|')
LITELLM_PORT=${LITELLM_PORT:-80}  # Default to 80 if no port specified

TIKA_HOST=$(echo "$TIKA_SERVER_URL" | sed -E 's|https?://([^:/]+).*|\1|')
TIKA_PORT=$(echo "$TIKA_SERVER_URL" | sed -E 's|https?://[^:]+:?([0-9]+)?.*|\1|')
TIKA_PORT=${TIKA_PORT:-80}  # Default to 80 if no port specified

echo "Waiting for LiteLLM at $LITELLM_HOST:$LITELLM_PORT..."
until nc -z -w 5 "$LITELLM_HOST" "$LITELLM_PORT"; do
  echo "LiteLLM is unavailable - sleeping"
  sleep 2
done
echo "LiteLLM is up!"

echo "Waiting for Tika at $TIKA_HOST:$TIKA_PORT..."
until nc -z -w 5 "$TIKA_HOST" "$TIKA_PORT"; do
  echo "Tika is unavailable - sleeping"
  sleep 2
done
echo "Tika is up!"

echo "All required services are available. Starting OpenWebUI..."

# Start the original entrypoint command
exec "/app/entrypoint.sh" "$@" 