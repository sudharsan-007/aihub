FROM ghcr.io/open-webui/open-webui:latest

# Install curl and netcat for healthchecks
USER root
RUN apt-get update && apt-get install -y curl netcat-openbsd && rm -rf /var/lib/apt/lists/*
USER 1000

# Add a startup script to check dependencies before starting
COPY wait-for-services.sh /app/wait-for-services.sh
RUN chmod +x /app/wait-for-services.sh

# Expose the container port
EXPOSE 8080

# Set the entrypoint to our wait script
ENTRYPOINT ["/app/wait-for-services.sh"]

# The original CMD will be called by the wait script 