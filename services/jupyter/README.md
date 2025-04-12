# Jupyter Service

This service provides a Jupyter Lab environment for executing code, analyzing data, and developing algorithms.

## Deployment on Railway

### Configuration

The service is configured via `railway.json` with the following settings:

- **Builder**: Dockerfile
- **Region**: Southeast Asia (Singapore)
- **Resources**: 2 vCPU and 0.512 GB memory
- **Restart Policy**: On Failure (10 retries)
- **Serverless**: Disabled

### Environment Variables

Set the following environment variables in Railway:

```
JUPYTER_TOKEN=your_secure_token
```

### Deployment Steps

1. Ensure you have the `railway.json`, `Dockerfile`, `entrypoint.sh`, and `health_check.py` properly configured
2. Deploy the service using the Railway web interface
3. Once deployed, access the Jupyter Lab interface at the service URL

### Health Check

The service includes a dedicated health check endpoint at `/api/status` that Railway uses to verify the service is running properly. This is implemented as a separate lightweight HTTP server that runs alongside Jupyter.

## Features

- Pre-installed data science and AI packages
- Welcome notebook with examples
- Integration with the unified AI platform 