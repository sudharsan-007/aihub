FROM debian:bullseye-slim

# Install essential packages
RUN apt-get update && apt-get install -y \
    curl \
    docker.io \
    docker-compose \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Make scripts executable if any
RUN chmod +x *.sh || true

# Set entrypoint
ENTRYPOINT ["docker-compose", "up", "-d"] 