#!/bin/bash
# Standalone deployment script for LiteLLM service

# Create a temporary deployment directory
TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: $TEMP_DIR"

# Copy just the LiteLLM service files
echo "Copying LiteLLM service files..."
cp -r services/litellm/* $TEMP_DIR/

# Create a new repository.railway.app file to ensure Railway uses this as the root
echo "Creating Railway configuration..."
cat > $TEMP_DIR/railway.toml << EOL
[build]
builder = "DOCKERFILE"
dockerfilePath = "Dockerfile"
EOL

# Navigate to the temporary directory
cd $TEMP_DIR

# Initialize git repository (Railway needs this)
echo "Initializing Git repository..."
git init
git add .
git commit -m "Initial LiteLLM deployment"

# Deploy to Railway
echo "Deploying to Railway..."
echo "Follow the prompts to create a new service for LiteLLM"
railway up

# Clean up
echo "Cleaning up..."
cd -
rm -rf $TEMP_DIR

echo "LiteLLM deployment completed!"
echo "Don't forget to set up environment variables in the Railway dashboard." 