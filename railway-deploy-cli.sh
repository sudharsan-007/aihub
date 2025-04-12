#!/bin/bash
# Railway CLI deployment script for Unified AI Platform
# Make sure you have installed the Railway CLI (npm i -g @railway/cli)
# And logged in (railway login) before running this script

set -e  # Exit on any error

echo "========================================="
echo "  Unified AI Platform - Railway Deployer  "
echo "========================================="
echo ""

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "Railway CLI not found. Please install it with:"
    echo "npm i -g @railway/cli"
    exit 1
fi

# Verify login status
echo "Checking Railway login status..."
railway whoami || { echo "Please login with 'railway login' first"; exit 1; }

# Link to project
echo ""
echo "Linking to Railway project..."
railway link

# Deploy each service manually with better error handling
deploy_service() {
    local service_name=$1
    local service_path=$2
    
    echo ""
    echo "===== Deploying $service_name ====="
    
    # Create a temporary directory based on service directory
    echo "Setting up deployment for $service_name..."
    cd "$service_path"
    
    echo "Configuring Railway for $service_name..."
    railway project
    
    echo "Starting deployment for $service_name..."
    railway up
    
    echo "$service_name deployment initiated!"
    
    # Go back to original directory
    cd - > /dev/null
}

echo ""
echo "NOTE: This script will guide you through manual steps for each service."
echo "For each service, you'll need to:"
echo "1. Select your project when prompted"
echo "2. Create a new service or select existing when prompted"
echo "3. Proceed with deployment"
echo ""
read -p "Press Enter to continue..."

# Deploy each service
echo ""
echo "===== Deploying LiteLLM ====="
echo "1. Select your Railway project when prompted"
echo "2. Create/select a service named 'litellm'"
echo "3. Proceed with deployment"
cd services/litellm
railway up
cd - > /dev/null

echo ""
echo "===== Deploying OpenWebUI ====="
echo "1. Select your Railway project when prompted"
echo "2. Create/select a service named 'openwebui'"
echo "3. Proceed with deployment"
cd services/openwebui
railway up
cd - > /dev/null

echo ""
echo "===== Deploying Tika ====="
echo "1. Select your Railway project when prompted"
echo "2. Create/select a service named 'tika'"
echo "3. Proceed with deployment"
cd services/tika
railway up
cd - > /dev/null

echo ""
echo "===== Deploying SearXNG ====="
echo "1. Select your Railway project when prompted"
echo "2. Create/select a service named 'searxng'"
echo "3. Proceed with deployment"
cd services/searxng
railway up
cd - > /dev/null

echo ""
echo "===== Deploying Jupyter ====="
echo "1. Select your Railway project when prompted"
echo "2. Create/select a service named 'jupyter'"
echo "3. Proceed with deployment"
cd services/jupyter
railway up
cd - > /dev/null

echo ""
echo "===== Setting up Redis ====="
echo "To add Redis, go to the Railway dashboard,"
echo "select your project, click 'New', then 'Database',"
echo "and select 'Redis'."

echo ""
echo "==========================================================="
echo "  All services deployment initiated! Check Railway dashboard"
echo "  for deployment status and service URLs."
echo ""
echo "  Once all services are deployed, update the environment"
echo "  variables to connect services together."
echo "===========================================================" 