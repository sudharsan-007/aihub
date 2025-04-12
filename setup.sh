#!/bin/bash
# Setup script for Unified AI Platform

# Colors for terminal output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Unified AI Platform - Setup Assistant  ${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""

# Check if .env file exists
if [ -f .env ]; then
  echo -e "${YELLOW}Warning: .env file already exists.${NC}"
  read -p "Do you want to overwrite it? (y/n): " overwrite
  if [[ ! $overwrite =~ ^[Yy]$ ]]; then
    echo "Setup aborted. Existing .env file preserved."
    exit 0
  fi
fi

# Create .env file from .env.example
if [ -f .env.example ]; then
  cp .env.example .env
  echo -e "${GREEN}Created .env file from template.${NC}"
else
  echo -e "${RED}Error: .env.example file not found. Cannot create .env file.${NC}"
  exit 1
fi

echo ""
echo -e "${GREEN}Please provide the following information:${NC}"
echo -e "(Press Enter to keep the default value shown in brackets)"
echo ""

# Prompt for API keys
read -p "OpenRouter API Key: " openrouter_key
if [ ! -z "$openrouter_key" ]; then
  sed -i '' "s/your_openrouter_api_key/$openrouter_key/g" .env
fi

read -p "EdenAI API Key: " edenai_key
if [ ! -z "$edenai_key" ]; then
  sed -i '' "s/your_edenai_api_key/$edenai_key/g" .env
fi

# Generate a secure master key if not provided
read -p "LiteLLM Master Key (leave blank to generate): " litellm_key
if [ -z "$litellm_key" ]; then
  litellm_key=$(openssl rand -hex 16)
  echo -e "${GREEN}Generated LiteLLM Master Key: $litellm_key${NC}"
fi
sed -i '' "s/your_litellm_master_key/$litellm_key/g" .env

# Generate a secure Jupyter token if not provided
read -p "Jupyter Token (leave blank to generate): " jupyter_token
if [ -z "$jupyter_token" ]; then
  jupyter_token=$(openssl rand -hex 8)
  echo -e "${GREEN}Generated Jupyter Token: $jupyter_token${NC}"
fi
sed -i '' "s/your_jupyter_token/$jupyter_token/g" .env

# Generate secret keys for security
webui_secret=$(openssl rand -hex 16)
sed -i '' "s/change-me-in-production/$webui_secret/g" .env

searxng_secret=$(openssl rand -hex 16)
sed -i '' "s/SEARXNG_SECRET_KEY=change-me-in-production/SEARXNG_SECRET_KEY=$searxng_secret/g" .env

echo ""
echo -e "${GREEN}Setup completed!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Deploy to Railway using the following commands:"
echo "   git add ."
echo "   git commit -m \"Configure Unified AI Platform\""
echo "   git push"
echo ""
echo "2. Set up the environment variables in Railway or deploy directly:"
echo "   - For Railway, copy the environment variables from .env to your project settings"
echo ""
echo -e "${GREEN}Thank you for using Unified AI Platform!${NC}" 