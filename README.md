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

## Deployment

This project is optimized for deployment on Railway, with comprehensive deployment guides available in the documentation.

```bash
# Quick start with Docker Compose
git clone https://github.com/yourusername/unified-ai-platform.git
cd unified-ai-platform
cp .env.example .env
# Edit .env with your API keys
docker-compose up -d
```

## Documentation

- [Railway Deployment Guide](./docs/railway-deployment-guide.mdx)
- [OpenWebUI Configuration](./docs/openwebui-configuration.mdx)
- [Platform Architecture](./docs/unified-platform-architecture.mdx)

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 