# Unified AI Platform: Railway Deployment Guide

This comprehensive guide combines our unified AI platform architecture with step-by-step deployment instructions for Railway.

## Table of Contents

- [System Components](#system-components)
- [Unified Architecture](#unified-architecture)
- [Connection Flow](#connection-flow)
- [Data Flow Diagram](#data-flow-diagram)
- [Benefits of Centralized LiteLLM Architecture](#benefits-of-centralized-litellm-architecture)
- [Prerequisites](#prerequisites)
- [Step 1: Set Up Your Repository](#step-1-set-up-your-repository)
- [Step 2: Create Configuration Files](#step-2-create-configuration-files)
  - [railway.json](#railwayjson)
  - [Dockerfile](#dockerfile)
  - [docker-compose.yml](#docker-composeyml)
  - [litellm/config.yaml](#litellmconfigyaml)
  - [.env.example](#envexample)
  - [.gitignore](#gitignore)
- [Step 3: Push Your Repository to GitHub](#step-3-push-your-repository-to-github)
- [Step 4: Deploy to Railway](#step-4-deploy-to-railway)
  - [Create a new project in Railway](#create-a-new-project-in-railway)
  - [Configure Environment Variables](#configure-environment-variables)
  - [Set Up Railway Domains](#set-up-railway-domains)
  - [Configure Network Rules](#configure-network-rules)
  - [Deploy Your Project](#deploy-your-project)
- [Step 5: Configuring Your Services](#step-5-configuring-your-services)
  - [LiteLLM Configuration](#litellm-configuration)
  - [OpenWebUI Configuration](#openwebui-configuration)
- [Step 6: Testing Your Setup](#step-6-testing-your-setup)
  - [Test Text Generation](#test-text-generation)
  - [Test Image Generation](#test-image-generation)
  - [Test Document Processing](#test-document-processing)
  - [Test Web Search](#test-web-search)
  - [Test Code Execution](#test-code-execution)
- [Step 7: Setting Up Auto-Updates](#step-7-setting-up-auto-updates)
- [Step 8: Backup Strategy](#step-8-backup-strategy)
- [Troubleshooting](#troubleshooting)
  - [OpenWebUI can't connect to LiteLLM](#openwebui-cant-connect-to-litellm)
  - [LiteLLM UI not accessible](#litellm-ui-not-accessible)
  - [Models not showing up in OpenWebUI](#models-not-showing-up-in-openwebui)
- [Next Steps](#next-steps)
- [Conclusion](#conclusion)

## System Components

The unified AI platform consists of several containerized services working together:

| Application | Purpose | Docker Image | Internal Port | External Port |
| :-- | :-- | :-- | :-- | :-- |
| **OpenWebUI** | Frontend UI | ghcr.io/open-webui/open-webui:latest | 8080 | 3000 |
| **LiteLLM** | Universal model proxy | ghcr.io/berriai/litellm:main | 4000 | 4000¹ |
| **Jupyter** | Code execution | jupyter/minimal-notebook | 8888 | N/A |
| **Tika** | Document extraction | apache/tika:latest-full | 9998 | N/A |
| **Searxng** | Private search engine | searxng/searxng | 8080 | N/A |
| **Redis** | Cache for LiteLLM | redis:alpine | 6379 | N/A |

¹ Accessible via a separate domain for admin configuration

## Unified Architecture

```mermaid
graph TD
    User[User Browser] --> OWU[OpenWebUI:3000]
    
    subgraph "Railway Project"
        OWU --> LITELLM[LiteLLM:4000]
        OWU --> TIKA[Tika:9998]
        OWU --> JUPYTER[Jupyter:8888]
        OWU --> SEARXNG[Searxng:8080]
        
        LITELLM -->|"Text Models"| OPENROUTER[OpenRouter API]
        LITELLM -->|"Image Models"| EDENAI[Eden AI API]
        LITELLM --> REDIS[Redis Cache]
    end
    
    style User fill:#4CAF50
    style OWU fill:#2196F3
    style LITELLM fill:#FF9800
    style OPENROUTER fill:#9C27B0
    style EDENAI fill:#E91E63
    style JUPYTER fill:#607D8B
    style TIKA fill:#009688
    style SEARXNG fill:#3F51B5
    style REDIS fill:#795548
```

## Connection Flow

```mermaid
flowchart LR
    OWU[OpenWebUI] -- "All AI requests\nPort 4000" --> LITELLM
    LITELLM -- "Text generation" --> OPENROUTER
    LITELLM -- "Image generation" --> EDENAI
    OWU -- "Code execution\nPort 8888" --> JUPYTER
    OWU -- "Document extraction\nPort 9998" --> TIKA
    OWU -- "Web search\nPort 8080" --> SEARXNG
```

## Data Flow Diagram

```mermaid
sequenceDiagram
    participant User
    participant OpenWebUI
    participant LiteLLM
    participant OpenRouter
    participant EdenAI
    participant Jupyter
    participant Tika
    participant Searxng
    
    User->>OpenWebUI: Send query
    
    alt Text Generation
        OpenWebUI->>LiteLLM: Route text request
        LiteLLM->>OpenRouter: Forward to language model
        OpenRouter-->>LiteLLM: Return text response
        LiteLLM-->>OpenWebUI: Display response
    else Image Generation
        OpenWebUI->>LiteLLM: Route image request
        LiteLLM->>EdenAI: Forward to image model
        EdenAI-->>LiteLLM: Return generated image
        LiteLLM-->>OpenWebUI: Display image
    else Code Execution
        OpenWebUI->>Jupyter: Execute code
        Jupyter-->>OpenWebUI: Return execution result
    else Document Processing
        OpenWebUI->>Tika: Extract document content
        Tika-->>OpenWebUI: Return extracted text
        OpenWebUI->>OpenWebUI: Create vector embeddings
    else Web Search
        OpenWebUI->>Searxng: Send search query
        Searxng-->>OpenWebUI: Return search results
    end
    
    OpenWebUI-->>User: Display final output
```

## Benefits of Centralized LiteLLM Architecture

| Feature | Implementation | Benefit |
| :-- | :-- | :-- |
| **Unified Logging** | All model calls go through LiteLLM | Centralized request tracking |
| **Cost Management** | LiteLLM budget controls | Single point for spending limits |
| **Fallback Models** | Configure in LiteLLM config | Automatic retry on failures |
| **Caching** | Redis container | Reduce duplicate API calls |
| **Rate Limiting** | LiteLLM built-in | Prevent API throttling |

## Prerequisites

Before you begin deployment on Railway, you'll need:

- GitHub account
- [Railway account](https://railway.app) (sign up is free)
- API keys for:
  - [OpenRouter](https://openrouter.ai) (for text models)
  - [EdenAI](https://edenai.co) (for image generation)

## Step 1: Set Up Your Repository

1. Create a new GitHub repository:
   - Go to GitHub and create a new repository named `unified-ai-platform`
   - Initialize with a README

2. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/YOUR-USERNAME/unified-ai-platform.git
   cd unified-ai-platform
   ```

3. Create the following directory structure:
   ```
   unified-ai-platform/
   ├── railway.json
   ├── docker-compose.yml
   ├── .env.example
   ├── .gitignore
   ├── litellm/
   │   └── config.yaml
   └── README.md
   ```

## Step 2: Create Configuration Files

### railway.json

Create a `railway.json` file to define your Railway project setup:

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "DOCKERFILE",
    "dockerfilePath": "Dockerfile"
  },
  "deploy": {
    "startCommand": "docker-compose up -d",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### Dockerfile

Create a `Dockerfile` at the root of your project:

```dockerfile
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
```

### docker-compose.yml

Create a `docker-compose.yml` file with all your services:

```yaml
version: "3.8"
services:
  openwebui:
    image: ghcr.io/open-webui/open-webui:latest
    container_name: openwebui
    ports:
      - "${PORT:-3000}:8080"
    environment:
      - OPENAI_API_BASE_URL=http://litellm:4000/v1
      - OPENAI_API_KEY=${LITELLM_MASTER_KEY}
      - CONTENT_EXTRACTION_ENGINE=tika
      - TIKA_SERVER_URL=http://tika:9998
      - ENABLE_RAG_WEB_SEARCH=true
      - RAG_WEB_SEARCH_ENGINE=searxng
      - SEARXNG_QUERY_URL=http://searxng:8080/search?q=<query>
      - WEBUI_SECRET_KEY=${WEBUI_SECRET_KEY}
      - ENABLE_SIGNUP=${ENABLE_SIGNUP:-true}
      - ENABLE_LOGIN_FORM=${ENABLE_LOGIN_FORM:-true}
      - WEBUI_NAME=${WEBUI_NAME:-"My Unified AI Platform"}
      - ENABLE_IMAGE_GENERATION=true
      - IMAGE_GENERATION_ENGINE=openai
      - ENABLE_CODE_INTERPRETER=true
    volumes:
      - openwebui-data:/app/backend/data
    depends_on:
      - litellm
      - tika
      - searxng

  litellm:
    image: ghcr.io/berriai/litellm:main
    container_name: litellm
    ports:
      - "${LITELLM_PORT:-4000}:4000"
    environment:
      - LITELLM_CONFIG_PATH=/app/config.yaml
      - OPENROUTER_API_KEY=${OPENROUTER_API_KEY}
      - EDENAI_API_KEY=${EDENAI_API_KEY}
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
      - COHERE_API_KEY=${COHERE_API_KEY}
      - LITELLM_MASTER_KEY=${LITELLM_MASTER_KEY}
    volumes:
      - ./litellm/config.yaml:/app/config.yaml
      - litellm-data:/app/data
    depends_on:
      - cache

  cache:
    image: redis:alpine
    container_name: redis-cache
    volumes:
      - redis-data:/data

  jupyter:
    image: jupyter/minimal-notebook:latest
    container_name: jupyter
    environment:
      - JUPYTER_TOKEN=${JUPYTER_TOKEN}
    volumes:
      - jupyter-data:/home/jovyan/work

  tika:
    image: apache/tika:latest-full
    container_name: tika

  searxng:
    image: searxng/searxng
    container_name: searxng
    environment:
      - SEARXNG_BASE_URL=${SEARXNG_BASE_URL:-http://localhost:8080/}
    volumes:
      - searxng-data:/etc/searxng

volumes:
  openwebui-data:
  litellm-data:
  redis-data:
  jupyter-data:
  searxng-data:
```

### litellm/config.yaml

Create the LiteLLM configuration file:

```yaml
model_list:
  # Text models via OpenRouter
  - model_name: gpt-3.5-turbo
    litellm_params:
      model: openrouter/openai/gpt-3.5-turbo
      api_key: ${OPENROUTER_API_KEY}

  - model_name: gpt-4
    litellm_params:
      model: openrouter/openai/gpt-4
      api_key: ${OPENROUTER_API_KEY}
  
  - model_name: claude-3-opus
    litellm_params:
      model: openrouter/anthropic/claude-3-opus
      api_key: ${OPENROUTER_API_KEY}

  - model_name: claude-3-sonnet
    litellm_params:
      model: openrouter/anthropic/claude-3-sonnet
      api_key: ${OPENROUTER_API_KEY}

  # Image models via EdenAI
  - model_name: dall-e-3
    litellm_params:
      model: edenai/openai/dall-e-3
      api_key: ${EDENAI_API_KEY}
  
  - model_name: midjourney
    litellm_params:
      model: edenai/midjourney/v6
      api_key: ${EDENAI_API_KEY}

  - model_name: stable-diffusion-3
    litellm_params:
      model: edenai/stability/stable-diffusion-3
      api_key: ${EDENAI_API_KEY}

general_settings:
  # Common settings
  completion_to_prompt: true
  default_fallback_strategy: "longest_context"
  
  # Cache config
  cache: true
  cache_params:
    type: "redis"
    host: "cache"
    port: 6379
    
  # Logging and monitoring
  log_level: "info"

# Configure proxy UI access
router_settings:
  # IMPORTANT: This exposes the LiteLLM UI
  expose_ui: true
  ui_username: "${LITELLM_UI_USERNAME:-admin}"
  ui_password: "${LITELLM_UI_PASSWORD:-${LITELLM_MASTER_KEY}}"
```

### .env.example

Create a `.env.example` file with all required environment variables:

```ini
# PORT configuration
PORT=3000
LITELLM_PORT=4000

# API Keys for model providers
OPENROUTER_API_KEY=sk-or-your-openrouter-key
EDENAI_API_KEY=your-edenai-key

# Optional: Add other provider keys if needed
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
COHERE_API_KEY=

# Security
LITELLM_MASTER_KEY=your-secure-master-key-for-litellm
LITELLM_UI_USERNAME=admin
JUPYTER_TOKEN=your-secure-jupyter-token

# OpenWebUI Settings
WEBUI_SECRET_KEY=your-webui-secret-key
WEBUI_NAME=My Unified AI Platform
ENABLE_SIGNUP=true
ENABLE_LOGIN_FORM=true

# SearXNG Settings
SEARXNG_BASE_URL=http://localhost:8080/
```

### .gitignore

Create a `.gitignore` file:

```
.env
data/
```

## Step 3: Push Your Repository to GitHub

Add your files to git and push to GitHub:

```bash
git add .
git commit -m "Initial commit with project configuration"
git push
```

## Step 4: Deploy to Railway

### Create a new project in Railway

1. Login to [Railway.app](https://railway.app)
2. Go to Dashboard and click "New Project"
3. Select "Deploy from GitHub repo"
4. Connect your GitHub account if not already connected
5. Select your `unified-ai-platform` repository

### Configure Environment Variables

1. In your Railway project dashboard, go to the "Variables" tab
2. Add all environment variables from your `.env.example` file
3. Be sure to set actual values for:
   - `OPENROUTER_API_KEY`
   - `EDENAI_API_KEY` (if using image generation)
   - `LITELLM_MASTER_KEY` (create a secure random string)
   - `WEBUI_SECRET_KEY` (create a secure random string)
   - `JUPYTER_TOKEN` (create a secure random string)

### Set Up Railway Domains

1. Go to the "Settings" tab in your Railway project
2. Under "Domains", generate a domain for your service
3. Create two domains:
   - One for OpenWebUI: e.g., `ai-platform.railway.app`
   - One for LiteLLM UI: e.g., `litellm-config.railway.app`

### Configure Network Rules

1. In the "Settings" tab, under "Networking"
2. Add these port mappings:
   - Port 3000 → `ai-platform.railway.app`
   - Port 4000 → `litellm-config.railway.app`

### Deploy Your Project

1. Go to the "Deployments" tab
2. Click "Deploy Now"
3. Wait for the deployment to complete

## Step 5: Configuring Your Services

Once deployed, you'll need to configure each service:

### LiteLLM Configuration

1. Access the LiteLLM UI at your assigned domain (e.g., `https://litellm-config.railway.app/ui`)
2. Log in with the username and password (default: admin/your-LITELLM_MASTER_KEY)
3. You can:
   - Test models
   - View spending
   - Check logs
   - Update model configurations

### OpenWebUI Configuration

1. Access OpenWebUI at your assigned domain (e.g., `https://ai-platform.railway.app`)
2. Create an admin account
3. Navigate to Admin Panel → Settings → Connections
4. Verify the OpenAI API connection is working:
   - URL: `http://litellm:4000/v1`
   - API Key: Your LITELLM_MASTER_KEY

5. Configure document extraction:
   - Admin Panel → Settings → Documents
   - Content Extraction Engine: "Tika"
   - Tika Server URL: `http://tika:9998`

6. Configure web search:
   - Admin Panel → Settings → Web Search
   - Enable Web Search
   - Web Search Engine: "searxng"
   - SearXNG Query URL: `http://searxng:8080/search?q=<query>`

## Step 6: Testing Your Setup

### Test Text Generation

1. In OpenWebUI, start a new chat
2. You should see all models configured in LiteLLM available in the model dropdown
3. Test a text completion with different models (GPT-4, Claude-3, etc.)

### Test Image Generation

1. In OpenWebUI, click the image generation icon
2. Select a model (DALL-E 3, Midjourney, etc.)
3. Enter a prompt and generate an image

### Test Document Processing

1. Navigate to Workspace → Knowledge
2. Create a new Collection
3. Upload a PDF or other document file
4. Verify that the document is properly processed and can be used in RAG

### Test Web Search

1. In a chat, enable web search
2. Ask a question that requires current information
3. Verify that search results are retrieved and included in the response

### Test Code Execution

1. In a chat, write a code snippet (Python, JavaScript, etc.)
2. The code should be executed and the results displayed

## Step 7: Setting Up Auto-Updates

Railway automatically rebuilds your app when you push changes to your GitHub repository. To set up auto-updates for Docker images:

1. Create a GitHub Actions workflow file at `.github/workflows/update-dockerfiles.yml`:

```yaml
name: Check for Docker Image Updates

on:
  schedule:
    - cron: '0 0 * * 0'  # Run weekly on Sundays
  workflow_dispatch:  # Allow manual runs

jobs:
  check-updates:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Check for OpenWebUI updates
        run: |
          latest_tag=$(curl -s https://api.github.com/repos/open-webui/open-webui/releases/latest | jq -r '.tag_name')
          echo "Latest OpenWebUI tag: $latest_tag"
          # Update your docker-compose if needed
      
      - name: Check for LiteLLM updates
        run: |
          latest_tag=$(curl -s https://api.github.com/repos/BerriAI/litellm/releases/latest | jq -r '.tag_name')
          echo "Latest LiteLLM tag: $latest_tag"
          # Update your docker-compose if needed
      
      - name: Commit and push if there are changes
        run: |
          git config --global user.name "GitHub Actions"
          git config --global user.email "actions@github.com"
          git add docker-compose.yml
          git diff --staged --quiet || git commit -m "Update Docker images to latest versions"
          git push
```

## Step 8: Backup Strategy

Railway doesn't provide built-in backup solutions for volumes, so we'll set up an external backup:

1. Add a GitHub Actions workflow file at `.github/workflows/backup.yml`:

```yaml
name: Backup Railway Data

on:
  schedule:
    - cron: '0 1 * * *'  # Run daily at 1 AM
  workflow_dispatch:  # Allow manual runs

jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
      - name: Install Railway CLI
        run: npm i -g @railway/cli
      
      - name: Login to Railway
        run: railway login --token ${{ secrets.RAILWAY_TOKEN }}
      
      - name: Execute Backup Command
        run: |
          railway run -s openwebui "tar -czf /tmp/backup-$(date +%Y%m%d).tar.gz -C /app/backend/data ."
          railway run -s openwebui "cat /tmp/backup-$(date +%Y%m%d).tar.gz" > backup-$(date +%Y%m%d).tar.gz
      
      - name: Upload Backup to GitHub Artifacts
        uses: actions/upload-artifact@v3
        with:
          name: backup-$(date +%Y%m%d)
          path: backup-$(date +%Y%m%d).tar.gz
          retention-days: 7
```

You'll need to:
1. Create a Railway token: Go to Railway dashboard → Account Settings → Tokens
2. Add the token as a GitHub secret named `RAILWAY_TOKEN`

## Troubleshooting

### OpenWebUI can't connect to LiteLLM

If you're having trouble connecting OpenWebUI to LiteLLM:

1. Check environment variables are correctly set in Railway
2. Verify internal networking is properly configured
3. Check Railway logs for both services
4. Test the LiteLLM API directly with:
   ```bash
   curl -X POST https://litellm-config.railway.app/v1/chat/completions \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_LITELLM_MASTER_KEY" \
     -d '{
       "model": "gpt-3.5-turbo",
       "messages": [{"role": "user", "content": "Hello, world"}]
     }'
   ```

### LiteLLM UI not accessible

If you cannot access the LiteLLM UI:

1. Verify the `router_settings.expose_ui` is set to `true` in the config.yaml
2. Check that the LITELLM_PORT variable is set to 4000
3. Ensure you have created a domain for port 4000 in Railway
4. Check Railway logs for any errors

### Models not showing up in OpenWebUI

If models are not appearing in OpenWebUI:

1. Check LiteLLM logs to ensure API keys are valid
2. Verify the model list in config.yaml is correctly formatted
3. Restart the containers from the Railway dashboard
4. Check the OpenWebUI connection settings

## Next Steps

Once your platform is up and running, consider these enhancements:

1. **Add more models**: Expand your LiteLLM config.yaml to include more models
2. **Customize OpenWebUI**: Modify settings like themes and default models
3. **Integrate with other tools**: Add more services to your Docker Compose file
4. **Set up monitoring**: Add services like Prometheus/Grafana for monitoring
5. **Multi-region deployment**: Deploy in multiple Railway regions for lower latency

## Conclusion

You now have a fully functional unified AI platform deployed on Railway, with:
- OpenWebUI as your frontend interface
- LiteLLM as your model proxy with an exposed UI for configuration
- Jupyter Notebook for code execution
- Apache Tika for document processing
- SearXNG for private web searches

All components are interconnected and configured to work together seamlessly, giving you a powerful, self-hosted alternative to paid AI services. 