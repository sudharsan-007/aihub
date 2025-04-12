FROM ghcr.io/berriai/litellm:main

WORKDIR /app

# Copy the configuration file
COPY config.yaml /app/config.yaml

# Set environment variables
ENV LITELLM_CONFIG_PATH="/app/config.yaml"
ENV LITELLM_PORT=4000
ENV LITELLM_HOST=0.0.0.0
ENV LITELLM_ADMIN_UI=true
ENV TELEMETRY=false

# Expose the container port
EXPOSE 4000

# The container already has an entrypoint 