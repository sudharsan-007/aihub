# Unified AI Platform - Railway Deployment Guide

This repository contains separate services that make up the Unified AI Platform, designed to be deployed on Railway.

## Services Overview

| Service | Purpose | Port | Base Image |
|---------|---------|------|------------|
| OpenWebUI | Frontend user interface | 8080 | ghcr.io/open-webui/open-webui:latest |
| LiteLLM | Universal model proxy | 4000 | ghcr.io/berriai/litellm:main |
| Tika | Document extraction | 9998 | apache/tika:latest-full |
| SearXNG | Private search engine | 8080 | searxng/searxng |
| Jupyter | Code execution | 8888 | jupyter/minimal-notebook:latest |
| Redis | Caching for LiteLLM | 6379 | redis:alpine (Use Railway Redis template) |

## Deployment Steps

### 1. Initial Setup

1. Fork or clone this repository to your GitHub account
2. Push any changes to your repository
3. Create a new Railway account if you don't have one

### 2. Deploy Each Service

#### Method 1: Manual Service Creation (Recommended for First Time)

For each service:

1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your repository
4. In the service settings:
   - Set "Source Directory" to the service directory (e.g., `services/openwebui`)
   - Add the necessary environment variables (copy from the `.env.example` files)
   - Deploy the service
   - Set up a domain for the service (Custom or Railway-provided)

#### Method 2: Using Railway Monorepo Support

Railway offers built-in monorepo support:

1. Create a new project in Railway
2. Connect to your GitHub repository
3. Railway will detect the `railway.toml` file at the root
4. Select which services to deploy
5. Configure environment variables for each service

### 3. Set Up Redis Service

For Redis, use Railway's template:

1. Click "New Service" in your project
2. Choose "Template"
3. Select "Redis"
4. Note the connection details for use in LiteLLM service

### 4. Update Service Connection URLs

After all services are deployed:

1. Get the URLs for each service from Railway
2. Update the environment variables in services that need to connect to other services:
   - In OpenWebUI: Update `OPENAI_API_BASE_URL` to point to your LiteLLM URL
   - In OpenWebUI: Update `TIKA_SERVER_URL` to point to your Tika URL
   - In OpenWebUI: Update `SEARXNG_QUERY_URL` to point to your SearXNG URL
   - In LiteLLM: Update `REDIS_HOST` to point to your Redis service

### 5. Verify Connectivity

1. Access the OpenWebUI interface through its URL
2. Create an account (first account will be admin)
3. Verify all features work:
   - Model connection through LiteLLM
   - Document processing through Tika
   - Web search through SearXNG
   - Code execution through Jupyter

## Communication Between Services

Railway offers two ways for services to communicate:

### Public Domain Method
Services can connect to each other using their public domains:
```
OPENAI_API_BASE_URL=https://litellm-your-project.railway.app/v1
TIKA_SERVER_URL=https://tika-your-project.railway.app
```

### Railway Internal Network
For better security, Railway provides an internal network for service-to-service communication:
```
OPENAI_API_BASE_URL=http://litellm.railway.internal:4000/v1
TIKA_SERVER_URL=http://tika.railway.internal:9998
```

For the internal method to work, you must name your services with the same name used in the connection string.

## Important Notes

- Each service needs its own environment variables (see `.env.example` files)
- API keys (OpenRouter, EdenAI) should be added to the LiteLLM service
- Generate secure tokens for LITELLM_MASTER_KEY and JUPYTER_TOKEN
- For security, only expose necessary services to the public 