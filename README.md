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

### Deployment Structure

The repository is organized into separate services in the `services/` directory:

```
services/
├── openwebui/   # Frontend UI
├── litellm/     # Model proxy
├── tika/        # Document processing
├── searxng/     # Web search
├── jupyter/     # Code execution
└── README.md    # Deployment instructions
```

### Deployment Steps

For detailed deployment instructions, see the [Services Deployment Guide](services/README.md).

## Documentation

- [Railway Deployment Guide](docs/railway-deployment-guide.md)
- [OpenWebUI Configuration](docs/openwebui-configuration.md)
- [Platform Architecture](docs/unified-platform-architecture.md)

## Previous Monolithic Approach

The previous version of this project used a monolithic Docker Compose approach, which is still available in the `docker-compose.yml` file at the root of the repository. However, the multi-service approach is recommended for Railway deployment.

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 