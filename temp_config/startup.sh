#!/bin/bash

# Copy config file to the right location if it exists
if [ -f /app/config/litellm_config.yaml ]; then
    echo "Using config file from volume..."
else
    echo "No config file found in volume, copying default..."
    cp /app/litellm_config.yaml /app/config/litellm_config.yaml
fi

# Start LiteLLM with the config file
exec litellm --config /app/config/litellm_config.yaml 