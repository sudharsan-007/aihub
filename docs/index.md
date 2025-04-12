# Unified AI Platform

A comprehensive, self-hosted AI platform combining OpenWebUI frontend with LiteLLM as a universal model proxy, along with supporting services for document processing, web search, and code execution.

## Documentation Contents

- [OpenWebUI Configuration](openwebui-configuration) - Comprehensive configuration guide for OpenWebUI
- [Railway Deployment Guide](railway-deployment-guide) - Step-by-step deployment guide for Railway
- [Unified Platform Architecture](unified-platform-architecture) - Technical architecture and component specifications

### Memory Bank
- [Project Brief](../memory-bank/projectbrief) - Foundation document defining core requirements and goals
- [Product Context](../memory-bank/productContext) - Why this project exists and problems it solves
- [System Patterns](../memory-bank/systemPatterns) - System architecture and design patterns in use
- [Technical Context](../memory-bank/techContext) - Technologies used and technical constraints
- [Active Context](../memory-bank/activeContext) - Current work focus and next steps
- [Progress](../memory-bank/progress) - What works, what's left to build, and current status

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

## Getting Started

See the [Railway Deployment Guide](railway-deployment-guide) for detailed setup instructions. 