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
| Caching | Reduce API calls | Redis |

## Key Features

- Text generation with multiple models (GPT-4, Claude, etc.)
- Image generation (Stable Diffusion, Midjourney via API)
- Document understanding via RAG (Retrieval Augmented Generation)
- Web search capabilities for real-time information
- Code execution for computational tasks
- Centralized logging and cost management

## Railway Deployment

This project uses a multi-service architecture for deployment on Railway.app, giving each component its own service and domain. This approach provides:

- **Individual Scaling**: Scale services based on their specific needs
- **Separate Domains**: Access each service via its own domain
- **Independent Updates**: Update components without affecting others
- **Better Resource Allocation**: Allocate resources where they're needed most

### Current Deployment Architecture

The platform consists of the following services deployed directly on Railway using official prebuilt Docker images:

1. **OpenWebUI** - Frontend interface for user interactions
   - Image: `ghcr.io/open-webui/open-webui:latest`
   - URL: `https://openwebui-production-[hash].up.railway.app`

2. **LiteLLM** - Model proxy for unified AI model access
   - Image: `ghcr.io/berriai/litellm:main`
   - URL: `https://litellm-ruog-production.up.railway.app`

3. **Redis** - Caching layer for improved performance
   - Image: `redis:alpine`
   - Internal access only

4. **PostgreSQL** - Database for LiteLLM
   - Uses Railway's managed PostgreSQL
   - Internal access only

5. **Tika** - Document processing service
   - Image: `apache/tika:latest-full`
   - URL: `https://tika-production.up.railway.app`

6. **SearXNG** - Privacy-focused web search engine
   - Image: `searxng/searxng`
   - URL: `https://searxng-production-4499.up.railway.app`

7. **JupyterLab** - Interactive code execution environment
   - Image: `jupyter/minimal-notebook:latest`
   - URL: `https://jupyterlab-production-bbcb.up.railway.app`

### Service Connectivity

Services communicate with each other using Railway's internal network:

- OpenWebUI connects to LiteLLM for model access
- OpenWebUI connects to Tika for document processing
- OpenWebUI connects to SearXNG for web search capabilities
- OpenWebUI connects to JupyterLab for code execution
- LiteLLM connects to Redis for caching
- LiteLLM connects to PostgreSQL for data storage
- SearXNG connects to Redis for rate limiting

### Deployment Steps

To replicate this deployment:

1. Create a new project on Railway.app
2. Deploy each service using the corresponding Docker image
3. Configure environment variables for proper interconnection
4. Create volumes for persistent data storage
5. Set up internal networking using Railway's built-in DNS

## Access Points

- **Main UI**: Access OpenWebUI at your assigned Railway domain
- **Admin Interface**: Access LiteLLM admin at `/admin` path on the LiteLLM domain
- **Code Execution**: Access JupyterLab directly through its assigned domain
- **Document Processing**: Tika is used internally by OpenWebUI
- **Web Search**: SearXNG is used internally by OpenWebUI

## Documentation

For more detailed information:

- [Platform Architecture](docs/unified-platform-architecture.md)
- [OpenWebUI Configuration](docs/openwebui-configuration.md)

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 