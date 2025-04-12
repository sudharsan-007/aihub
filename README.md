# Unified AI Platform

A comprehensive, self-hosted AI platform combining OpenWebUI frontend with LiteLLM as a universal model proxy, along with supporting services for document processing, web search, and code execution.

## Overview

This project solves the problem of fragmented AI workflows by unifying multiple AI services into a single, self-hosted platform:

- **Single Interface**: Access multiple AI models through one unified UI
- **Centralized Management**: Manage all AI services, logs, and costs in one place
- **Privacy Control**: Keep sensitive data within your own infrastructure 
- **Extensibility**: Add new models and services with minimal configuration

## Core Components

| Component | Purpose | Technology |
|-----------|---------|------------|
| Frontend | User interface | OpenWebUI |
| Model Proxy | Unified API layer | LiteLLM |
| Document Processing | Extract text from files | Apache Tika |
| Web Search | Retrieve real-time information | SearXNG |
| Code Execution | Run code snippets | Jupyter Notebook |

## Key Features

- Text generation with multiple models (GPT-4, Claude, etc.)
- Image generation (Stable Diffusion, Midjourney via API)
- Document understanding via RAG (Retrieval Augmented Generation)
- Web search capabilities for real-time information
- Code execution for computational tasks
- Centralized logging and cost management

## Railway Deployment

This project is designed to be deployed on Railway.app, a container-based platform that simplifies deployment.

### Deployment Steps

1. **Fork or Clone this Repository**
   - Create your own copy of this repository on GitHub

2. **Create a New Railway Project**
   - Go to [Railway.app](https://railway.app) and create a new project
   - Link your GitHub repository to the project

3. **Configure Environment Variables**
   - Add the required API keys in Railway's environment variables:
     - `OPENROUTER_API_KEY`: Your OpenRouter API key
     - `EDENAI_API_KEY`: Your EdenAI API key
     - `LITELLM_MASTER_KEY`: Master key for LiteLLM access
     - `JUPYTER_TOKEN`: Token for Jupyter authentication

4. **Deploy**
   - Railway will automatically build and deploy the project
   - Access the services via the Railway-provided domains

## Documentation

- [Railway Deployment Guide](docs/railway-deployment-guide.md)
- [OpenWebUI Configuration](docs/openwebui-configuration.md)
- [Platform Architecture](docs/unified-platform-architecture.md)

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 