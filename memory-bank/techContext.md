# Technical Context

## Technologies Used

### Core Services

| Service | Technology | Purpose |
|---------|------------|---------|
| **OpenWebUI** | Docker Image: `ghcr.io/open-webui/open-webui:latest` | Frontend user interface for the platform |
| **LiteLLM** | Docker Image: `ghcr.io/berriai/litellm:main` | Universal model proxy for AI model access |
| **Jupyter** | Docker Image: `jupyter/minimal-notebook` | Code execution and notebook environment |
| **Tika** | Docker Image: `apache/tika:latest-full` | Document extraction and processing |
| **SearxNG** | Docker Image: `searxng/searxng` | Private search engine functionality |
| **Redis** | Docker Image: `redis:alpine` | Caching for LiteLLM to reduce API calls |

### External Dependencies

| Service | Purpose | Required API |
|---------|---------|-------------|
| **OpenRouter** | Text model access | OpenRouter API Key |
| **EdenAI** | Image generation | EdenAI API Key |
| **Optional Models** | Additional model access | OpenAI, Anthropic, Cohere API Keys |

### Infrastructure

| Component | Technology |
|-----------|------------|
| **Hosting Platform** | Railway.app |
| **Container Orchestration** | Docker Compose via Railway |
| **Version Control** | GitHub |
| **CI/CD** | GitHub Actions for updates and backups |
| **Networking** | Railway networking with custom domains |

## Development Setup

### Required Accounts
- GitHub account
- Railway account
- OpenRouter account
- EdenAI account (for image generation)

### Local Development
The project can be developed locally using Docker Compose:

```bash
# Clone the repository
git clone https://github.com/YOUR-USERNAME/unified-ai-platform.git
cd unified-ai-platform

# Create .env file (copy from .env.example)
cp .env.example .env

# Edit .env with your API keys
nano .env

# Start the services
docker-compose up -d
```

### Configuration Files

| File | Purpose |
|------|---------|
| `docker-compose.yml` | Defines services, networks, and volumes |
| `litellm/config.yaml` | LiteLLM configuration for models and settings |
| `.env` | Environment variables for all services |
| `railway.json` | Railway deployment configuration |
| `Dockerfile` | Base container for Railway deployment |

## Technical Constraints

1. **Railway Limitations**
   - No built-in volume backup mechanism
   - Container resource limits based on plan
   - Custom domain limitations based on plan

2. **External API Constraints**
   - Rate limits on OpenRouter, EdenAI, and other providers
   - Cost considerations for external API calls
   - Model availability differences between providers

3. **Network Constraints**
   - Internal service communication relies on Docker networking
   - External access requires proper port exposure
   - Service interdependency requires proper startup order

## Dependencies

### Internal Dependencies
```
OpenWebUI → LiteLLM → Redis
OpenWebUI → Tika
OpenWebUI → Jupyter
OpenWebUI → SearxNG
```

### External Dependencies
```
LiteLLM → OpenRouter API
LiteLLM → EdenAI API
LiteLLM → (Optional) Other model provider APIs
```

## Security Considerations

1. **API Key Management**
   - All API keys stored as environment variables
   - Master key for LiteLLM access
   - UI credentials for admin interfaces

2. **Network Security**
   - Internal services not directly exposed
   - Only necessary ports exposed via Railway domains
   - UI authentication for exposed interfaces

3. **Data Security**
   - Persistent volumes for user data
   - Regular backup workflow for critical data
   - No sensitive data in repository 