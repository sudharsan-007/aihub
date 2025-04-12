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
- **Authentication**: Password-based

### Environment Variables

Set the following environment variables in Railway:

```
JUPYTER_PASSWORD=your_secure_password
```

### Deployment Steps

1. Ensure you have the `railway.json` and `Dockerfile` properly configured
2. Deploy the service using the Railway web interface
3. Once deployed, access the Jupyter Lab interface at the service URL
4. Log in using the password set in the JUPYTER_PASSWORD environment variable

### Integration with OpenWebUI

This Jupyter service is configured to work with OpenWebUI:

1. In OpenWebUI, configure the connection to use password authentication
2. Use the same password as set in the JUPYTER_PASSWORD environment variable
3. Use the internal Railway service URL (jupyterlab.railway.internal) for private networking

## Features

- Pre-installed data science and AI packages
- Welcome notebook with examples
- Integration with the unified AI platform
- Password authentication for secure access
- Persistent storage with Railway volumes 